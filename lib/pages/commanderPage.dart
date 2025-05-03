import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/pages/CommanderSteps/TypeColisStep.dart';
import 'package:lpr/pages/CommanderSteps/TypeEmballageStep.dart';
import 'package:lpr/pages/CommanderSteps/TypeDestinataireStep.dart';
import 'package:lpr/pages/CommanderSteps/PointRelaisStep.dart';
import 'package:lpr/pages/CommanderSteps/RecapitulatifStep.dart';
import 'package:lpr/pages/ListeColisPage.dart';

class CommanderPage extends StatefulWidget {
  const CommanderPage({super.key});

  @override
  State<CommanderPage> createState() => _CommanderPageState();
}

class _CommanderPageState extends State<CommanderPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final CommandeProcessController _controller = Get.find();

  int _currentPageIndex = 0;

  List<Widget> pages = [
    TypeColisStep(),
    Commander3(),
    TypeDestinataireStep(),
    PointRelaisStep(),
    RecapitulatifStep(),
  ];

  bool checkstep() {
    bool a = _controller.typeColis.value != null && _currentPageIndex == 0;
    bool b = _controller.typeEmballage.value != null && _currentPageIndex == 1;
    bool c = (_currentPageIndex == 2 &&
            _controller.typeDestinataire.value?.level == 1) ||
        (_currentPageIndex == 2 &&
            _controller.typeDestinataire.value?.level == 2 &&
            _controller.contactDestinataire.value != "" &&
            _controller.nomDestinataire.value != "");
    bool d = (_controller.pointRelais.value != null && _currentPageIndex == 3);
    return a || b || c || d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (_currentPageIndex > 0) {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut);
              } else {
                Get.dialog(
                  ConfirmDialog(
                    title: "😩😟 Hhmmm !",
                    message:
                        "En quittant cette page, vous allez perdre le processus de validation du relais.",
                    testOk: "Oui",
                    testCancel: "Non, je reste",
                    functionOk: () {
                      _controller.onInit();
                      Get.off(ListeColisPage());
                    },
                    functionCancel: () {
                      Get.back();
                    },
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING * 2),
          decoration: const BoxDecoration(
            color: MyColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.vertical_split_sharp,
                    size: 20,
                  ),
                  Spacer(),
                  Icon(
                    Icons.check,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.secondary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Row(
                    children: [
                      if (_currentPageIndex > 0)
                        Expanded(
                          flex: _currentPageIndex,
                          child: Container(
                            height: 9,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: MyColors.secondary, width: 0.5),
                              color: MyColors.primary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ).animate().moveX(duration: 400.ms),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.inventory,
                        size: 20,
                      ),
                      if (_currentPageIndex != pages.length)
                        Spacer(
                          flex: pages.length - _currentPageIndex,
                        )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0, color: MyColors.primary))),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: pages),
            ),
            SizedBox(height: Tools.PADDING),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: (_currentPageIndex > 0)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceAround,
                  children: [
                    if (_currentPageIndex > 0)
                      MainButton(
                          title: "Retour",
                          icon: Icons.chevron_left,
                          forward: false,
                          onPressed: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          }),
                    if (_currentPageIndex == pages.length - 1)
                      MainButtonInverse(
                        title: "Valider la relais",
                        icon: Icons.check,
                        onPressed: () {
                          _controller.create();
                        },
                      ).animate().fadeIn(duration: 1000.ms)
                    else if (checkstep())
                      MainButtonInverse(
                        title: "Suivant",
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ).animate().fadeIn(duration: 1000.ms)
                  ],
                );
              }),
            ),
            SizedBox(height: Tools.PADDING * 2),
          ],
        ),
      ),
    );
  }
}
