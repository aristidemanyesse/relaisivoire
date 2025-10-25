import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/confirmDialog.dart';
import 'package:relaisivoire/components/elements/main_button_icon_inverse.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/controllers/CommandeProcessController.dart';
import 'package:relaisivoire/controllers/HandleTypesController.dart';

class FormulaireContactDestinataire extends StatefulWidget {
  const FormulaireContactDestinataire({super.key});

  @override
  State<FormulaireContactDestinataire> createState() =>
      _FormulaireContactDestinataireState();
}

class _FormulaireContactDestinataireState
    extends State<FormulaireContactDestinataire> {
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _contactController = TextEditingController(
    text: "",
  );

  final HandleTypesController handleTypesController = Get.find();
  final CommandeProcessController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = _controller.nomDestinataire.value;
    _contactController.text = _controller.contactDestinataire.value;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: MyColors.primary,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Renseigner le destinataire",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(Tools.PADDING / 1.5),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  onChanged: (value) =>
                      _controller.nomDestinataire.value = value,
                  decoration: InputDecoration(
                    hintText: "Nom du destinataire...",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.transparent, // Fond transparent
                    prefixIcon: Icon(Icons.person, color: MyColors.primary),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Tools.PADDING / 1.5,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Bords arrondis
                      borderSide: BorderSide(
                        color: MyColors.primary,
                        width: 1.5,
                      ), // Contour
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: MyColors.primary, width: 2),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                const SizedBox(height: Tools.PADDING),
                TextField(
                  controller: _contactController,
                  onChanged: (value) =>
                      _controller.contactDestinataire.value = value,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: "Contact du destinataire...",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.transparent, // Fond transparent
                    prefixIcon: Icon(Icons.phone, color: MyColors.primary),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Tools.PADDING / 1.5,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Bords arrondis
                      borderSide: BorderSide(
                        color: MyColors.primary,
                        width: 1.5,
                      ), // Contour
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: MyColors.primary, width: 2),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                const SizedBox(height: Tools.PADDING),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainButtonInverse(
                      title: "Valider",
                      onPressed: () {
                        if (_contactController.text.isEmpty ||
                            _nameController.text.isEmpty) {
                          Tools.showErrorToast(
                            title: "Ooops",
                            message:
                                "Vous devez renseigner le nom et le contact",
                          );
                          return;
                        }
                        _controller.nomDestinataire.value =
                            _nameController.text;
                        _controller.contactDestinataire.value =
                            _contactController.text;

                        _controller.typeDestinataire.value =
                            handleTypesController.listeTypeDestinataires.value
                                .firstWhere((element) => element.level == 3);
                        Get.back();
                      },
                    ).animate().fadeIn(duration: 1000.ms),
                    MainButtonIconInverse(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icons.close,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
