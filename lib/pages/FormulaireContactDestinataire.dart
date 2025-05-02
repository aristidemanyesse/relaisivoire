import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';

class FormulaireContactDestinataire extends StatefulWidget {
  const FormulaireContactDestinataire({
    super.key,
  });

  @override
  State<FormulaireContactDestinataire> createState() =>
      _FormulaireContactDestinataireState();
}

class _FormulaireContactDestinataireState
    extends State<FormulaireContactDestinataire> {
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _contactController =
      TextEditingController(text: "");

  final CommandeProcessController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = _controller.nomDestinataire.value;
    _contactController.text = _controller.contactDestinataire.value;
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      final contact = await FlutterContacts.openExternalPick();
      setState(() {
        _nameController.text = contact?.displayName ?? "";
        _contactController.text = contact?.phones.first.normalizedNumber ?? "";

        _controller.nomDestinataire.value = _nameController.text;
        _controller.contactDestinataire.value = _contactController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Tools.PADDING,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    getContact();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.contact_phone,
                        color: MyColors.primary,
                        size: 40,
                      ),
                      const SizedBox(
                        width: Tools.PADDING / 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Choisir parmis mes",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text("contacts téléphoniques",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(
            height: Tools.PADDING,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Tools.PADDING * 3),
            child: Row(
              children: [
                Expanded(child: Divider()),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
                    child: Text("Ou")),
                Expanded(child: Divider()),
              ],
            ),
          ),
          const SizedBox(
            height: Tools.PADDING,
          ),
          TextField(
              controller: _nameController,
              onChanged: (value) => _controller.nomDestinataire.value = value,
              decoration: InputDecoration(
                hintText: "Nom du destinataire...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent, // Fond transparent
                prefixIcon: Icon(Icons.person, color: MyColors.primary),
                contentPadding:
                    EdgeInsets.symmetric(vertical: Tools.PADDING / 1.5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Bords arrondis
                  borderSide: BorderSide(
                      color: MyColors.primary, width: 1.5), // Contour
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: MyColors.primary, width: 2),
                ),
              ),
              style: Theme.of(context).textTheme.labelLarge!),
          const SizedBox(
            height: Tools.PADDING * 1.5,
          ),
          TextField(
              controller: _contactController,
              onChanged: (value) =>
                  _controller.contactDestinataire.value = value,
              decoration: InputDecoration(
                hintText: "Contact du destinataire...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent, // Fond transparent
                prefixIcon: Icon(Icons.phone, color: MyColors.primary),
                contentPadding:
                    EdgeInsets.symmetric(vertical: Tools.PADDING / 1.5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Bords arrondis
                  borderSide: BorderSide(
                      color: MyColors.primary, width: 1.5), // Contour
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: MyColors.primary, width: 2),
                ),
              ),
              style: Theme.of(context).textTheme.labelLarge!),
        ],
      ),
    );
  }
}
