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
                    const Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 30,
                        ),
                        SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: TextField(),
                        ),
                        SizedBox(width: Tools.PADDING),
                      ],
                    ),
                    const Spacer(),
                    const Row(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: 30,
                        ),
                        SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: TextField(),
                        ),
                        SizedBox(width: Tools.PADDING),
                      ],
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
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: Tools.PADDING / 2,
                                ),
                                Column(
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
