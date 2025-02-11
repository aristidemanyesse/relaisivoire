import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';

class Commander4 extends StatelessWidget {
  const Commander4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Get.height * 0.15,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Qui doit récuperer le colis ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Coordonnées du destinataire",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MyColors.beige),
                ),
              ],
            )),
        const Expanded(flex: 1, child: Wave()),
        Expanded(
          flex: 10,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: Tools.PADDING,
                ),
                Expanded(
                  child: Column(children: [
                    const Spacer(),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Nom du destinataire...",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent, // Fond transparent
                        prefixIcon: Icon(Icons.person, color: MyColors.bleu),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Bords arrondis
                          borderSide: BorderSide(
                              color: MyColors.bleu, width: 1.5), // Contour
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: MyColors.bleu, width: 2),
                        ),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Tools.PADDING * 2),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Contact du destinataire...",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent, // Fond transparent
                        prefixIcon: Icon(Icons.phone, color: MyColors.bleu),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: Tools.PADDING / 3),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Bords arrondis
                          borderSide: BorderSide(
                              color: MyColors.bleu, width: 1.5), // Contour
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(color: MyColors.bleu, width: 2),
                        ),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.contact_phone,
                                  color: MyColors.bleu,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text("contacts téléphoniques",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
