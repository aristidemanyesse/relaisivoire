import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/HandlePayementPopup.dart';
import 'package:lpr/pages/commander1.dart';
import 'package:lpr/pages/commander3.dart';
import 'package:lpr/pages/commander4.dart';
import 'package:lpr/pages/commander5.dart';
import 'package:lpr/pages/commander6.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommanderPage extends StatefulWidget {
  const CommanderPage({super.key});

  @override
  State<CommanderPage> createState() => _CommanderPageState();
}

class _CommanderPageState extends State<CommanderPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<Widget> pages = [
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
                      title: "Payer pour confirmer",
                      icon: Icons.check,
                      onPressed: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => HandlePayementPopup(),
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
