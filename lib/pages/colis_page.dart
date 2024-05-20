import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/components/elements/circle_indicator.dart';
import 'package:lpr/components/elements/barre.dart';
import 'package:lpr/components/widgets/step_recap.dart';
import 'package:lpr/pages/commander1.dart';
import 'package:lpr/pages/commander2.dart';
import 'package:lpr/pages/commander3.dart';
import 'package:lpr/pages/commander4.dart';
import 'package:lpr/pages/commander5.dart';
import 'package:lpr/pages/commander6.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Login_name.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/elements/prefix.dart';
import 'package:lpr/components/widgets/wave.dart';

class ColisPage extends StatefulWidget {
  const ColisPage({Key? key}) : super(key: key);

  @override
  State<ColisPage> createState() => _ColisPageState();
}

class _ColisPageState extends State<ColisPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                    height: Get.height * 0.22,
                    width: Get.size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                    decoration: const BoxDecoration(
                        color: MyColors.bleu,
                        border: Border.symmetric(
                            horizontal: BorderSide.none,
                            vertical: BorderSide.none)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey,
                        ),
                        Text(
                          "LPR - 458 965 230",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: MyColors.beige,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const Expanded(flex: 1, child: Wave()),
                Expanded(
                  flex: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Tools.PADDING * 2,
                    ),
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: Get.height * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Spacer(),
                              StepRecap(
                                  title: "Type de colis",
                                  subtitle: "Enveloppe - Porte-document"),
                              StepRecap(
                                  title: "Poids du colis",
                                  subtitle: "entre 2Kg et 5Kg"),
                              StepRecap(
                                  title: "NIveau d'emballage",
                                  subtitle: "Oui bien emballé"),
                              StepRecap(
                                  title: "Coordonnées du destinataire",
                                  subtitle: "Koumba Yacine - 07 859 569 20"),
                              StepRecap(
                                  title: "Lieu de livraison",
                                  subtitle: "Aly le bon - Marcory - Vridi"),
                              StepRecap(
                                  title: "Total à payer",
                                  subtitle: "1 200 Fcfa"),
                              Spacer(),
                            ],
                          ),
                        ),
                        Container(
                          height: Get.height * 0.5,
                          padding: const EdgeInsets.symmetric(
                              vertical: Tools.PADDING),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  CircleIndicator(text: "1"),
                                  BarreVerticale(),
                                  CircleIndicator(text: "2"),
                                  BarreVerticale(),
                                  CircleIndicator(text: "3"),
                                  BarreVerticale(),
                                  CircleIndicator(text: "4"),
                                  BarreVerticale(),
                                  CircleIndicator(text: "5"),
                                  BarreVerticale(),
                                  CircleIndicator(text: "6"),
                                ],
                              ),
                              Expanded(
                                child: Text("kjglkj"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            Container(
              height: Get.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButtonInverse(
                      title: "Me guider vers un point relais", onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
