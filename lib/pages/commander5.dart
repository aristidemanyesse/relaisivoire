import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';

class Commander5 extends StatelessWidget {
  const Commander5({
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
                  "Où doit-il récuperer le colis ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Lieu de récupe",
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.map_outlined,
                                size: 30,
                              ),
                              Text("Commune",
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainButton(title: "Choisir", onPressed: () {})
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.location_city,
                                size: 30,
                              ),
                              Text("Zone",
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainButton(title: "Choisir", onPressed: () {})
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                size: 30,
                              ),
                              Text("Point Relais",
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainButton(title: "Choisir", onPressed: () {})
                            ],
                          ),
                        ),
                        const SizedBox(width: Tools.PADDING),
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
