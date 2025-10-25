import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/pages/PleaseWait2.dart';
import 'package:relaisivoire/pages/ProfilPage.dart';

class ChangeInfosPage extends StatefulWidget {
  const ChangeInfosPage({super.key});

  @override
  State<ChangeInfosPage> createState() => _ChangeInfosPageState();
}

class _ChangeInfosPageState extends State<ChangeInfosPage> {
  GeneralController controller = Get.find();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  @override
  void initState() {
    _nameController.text =
        controller.client.value!.user.target?.firstName ?? "";
    _prenomController.text =
        controller.client.value!.user.target?.lastName ?? "";
    super.initState();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Changer mes informations",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, size: 35, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: Tools.PADDING * 2),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Votre nom *',
                      labelStyle: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: Colors.blue,
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: Tools.PADDING * 2),
                  TextField(
                    controller: _prenomController,
                    decoration: InputDecoration(
                      labelText: 'Votre prenom *',
                      labelStyle: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: Colors.blue,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  MainButtonInverse(
                    title: "Mettre à jour mes infos",
                    icon: Icons.check,
                    onPressed: () async {
                      Get.dialog(PleaseWait2());
                      controller.client.value!.update(
                        _nameController.text,
                        _prenomController.text,
                      );
                      Get.off(ProfilPage());
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
