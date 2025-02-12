import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/PleaseWait.dart';
import 'package:lpr/pages/commander1.dart';
import 'package:lpr/pages/commander3.dart';
import 'package:lpr/pages/commander4.dart';
import 'package:lpr/pages/commander5.dart';
import 'package:lpr/pages/commander6.dart';

class CommanderPage extends StatefulWidget {
  const CommanderPage({super.key});

  @override
  State<CommanderPage> createState() => _CommanderPageState();
}

class _CommanderPageState extends State<CommanderPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<Widget> pages = const [
    Commander1(),
    Commander3(),
    Commander4(),
    Commander5(),
    Commander6(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING * 2),
          decoration: const BoxDecoration(
            color: MyColors.bleu,
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
                      color: MyColors.beige.withOpacity(0.7),
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
                              border:
                                  Border.all(color: MyColors.beige, width: 0.5),
                              color: MyColors.bleu.withOpacity(0.9),
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
            border: Border(top: BorderSide(width: 0, color: MyColors.bleu))),
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
            Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Row(
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
                      title: "Confirmer le colis",
                      icon: Icons.check,
                      onPressed: () {
                        Get.dialog(
                          const PleaseWait(),
                        );
                      },
                    ).animate().fadeIn(duration: 1000.ms)
                  else
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
              ),
            ),
            SizedBox(height: Tools.PADDING),
          ],
        ),
      ),
    );
  }
}
