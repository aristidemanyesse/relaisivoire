import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/TypeDestinataireBloc.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/pages/FormulaireContactDestinataire.dart';

class TypeDestinataireStep extends StatefulWidget {
  TypeDestinataireStep({
    super.key,
  });

  @override
  State<TypeDestinataireStep> createState() => _TypeDestinataireStepState();
}

class _TypeDestinataireStepState extends State<TypeDestinataireStep> {
  final CommandeProcessController _controller = Get.find();
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _contactController =
      TextEditingController(text: "");

  final HandleTypesController handleTypesController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void pickContact() async {
    if (await FlutterContacts.requestPermission()) {
      final contact = await FlutterContacts.openExternalPick();
      setState(() {
        _nameController.text = contact?.displayName ?? "";
        _contactController.text = contact?.phones.first.normalizedNumber ?? "";

        if (contact != null) {
          _controller.nomDestinataire.value = contact.displayName;
          _controller.contactDestinataire.value =
              contact.phones.first.normalizedNumber;

          _controller.typeDestinataire.value = handleTypesController
              .listeTypeDestinataires.value
              .firstWhere((element) => element.level == 2);
        }
      });
    }
  }

  void getContact() async {
    Get.dialog(FormulaireContactDestinataire(), barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.primary,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.15,
                  child: Image.asset("assets/images/pattern.png",
                      fit: BoxFit.cover, width: Get.width),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Qui doit récuperer le colis ?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Coordonnées du destinataire",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyColors.secondary),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(height: 20, child: Wave()),
        Spacer(),
        Container(
          width: double.infinity,
          height: Get.height * 0.4,
          padding: const EdgeInsets.symmetric(
            horizontal: Tools.PADDING,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: handleTypesController.listeTypeDestinataires.value
                .map((typeDestinataire) {
              return GestureDetector(
                onTap: () {
                  if (typeDestinataire.level == 2) {
                    pickContact();
                  } else if (typeDestinataire.level == 3) {
                    getContact();
                  }
                },
                child: TypeDestinataireBloc(
                  isCalled: typeDestinataire.level != 1,
                  type: typeDestinataire,
                ),
              );
            }).toList(),
          ),
        ),
        Spacer(),
        Obx(() {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Text(_controller.nomDestinataire.value),
            Text(_controller.contactDestinataire.value)
          ]);
        }),
        Spacer(),
      ],
    );
  }
}
