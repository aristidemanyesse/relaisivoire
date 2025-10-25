import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/KeyBoardNumberPad.dart';
import 'package:relaisivoire/components/elements/confirmDialog.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/widgets/my_input_number.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/controllers/KeyBoardController.dart';
import 'package:relaisivoire/models/AdministrationApp/CustomUser.dart';
import 'package:relaisivoire/pages/Login_number.dart';
import 'package:relaisivoire/pages/PleaseWait2.dart';
import 'package:relaisivoire/services/SessionService.dart';
import 'package:relaisivoire/services/StoreService.dart';
import 'package:relaisivoire/services/SyncService.dart';

class ChangeNumberPage extends StatefulWidget {
  const ChangeNumberPage({super.key});

  @override
  State<ChangeNumberPage> createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends State<ChangeNumberPage> {
  KeyBoardController keyBoardController = Get.find();
  GeneralController controller = Get.find();
  String _number = "";

  @override
  void initState() {
    super.initState();
    keyBoardController.value.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Column(
        children: [
          SizedBox(height: Tools.PADDING),
          Container(
            margin: EdgeInsets.only(left: Tools.PADDING),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Changer mon numéro",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cette action implique un changement des informations de connexion.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Vous serez déconnecté pour pour appliquer les changements.",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Tools.PADDING),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, size: 35, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: Tools.PADDING),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Column(
                children: [
                  const Spacer(),
                  Obx(() {
                    _number = keyBoardController.value.value;
                    return MyInputNumber(nbPlaces: 10, value: _number);
                  }),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
                    child: KeyBoardNumberPad(limit: 10),
                  ),
                  Spacer(),
                  MainButtonInverse(
                    title: "Changer mon numéro de téléphone",
                    icon: Icons.check,
                    onPressed: () async {
                      if (_number == controller.client.value!.contact) {
                        Get.snackbar(
                          "❌ Ooops",
                          "Ce numéro est déjà celui que vous utilisez !",
                          colorText: MyColors.danger,
                        );
                        return;
                      }
                      Get.dialog(
                        ConfirmDialog(
                          title: "Confirmation",
                          message:
                              "Vous confirmez que le $_number est votre nouveau numéro de téléphone? Vous serez déconnecté pour appliquer ces changements. Voulez-vous vraiment continuer ?",
                          testOk: "Je confirme",
                          testCancel: "Non",
                          functionOk: () async {
                            Get.dialog(PleaseWait2());
                            try {
                              final response = await CustomUser.ifUserExists(
                                _number,
                              );
                              if (response) {
                                Get.back();
                                Get.snackbar(
                                  "❌ Ooops",
                                  "Ce numéro est déjà utilisé par un autre compte !",
                                  colorText: MyColors.danger,
                                );
                                return;
                              }
                              final res = await controller.client.value!
                                  .updateContact(_number);
                              if (res) {
                                final store = await getStore();
                                final session = SessionService(
                                  syncService: SyncService(store: store),
                                );
                                session.clearClientSession();
                                keyBoardController.onInit();
                                Get.offAll(LoginNumber());
                              }
                            } catch (e) {
                              Get.snackbar(
                                "Oops",
                                "Une erreur est survenue, veuillez réessayer plus tard!",
                              );
                            }
                          },
                          functionCancel: () {
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Tools.PADDING * 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
