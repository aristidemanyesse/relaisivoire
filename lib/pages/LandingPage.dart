import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/widgets/IntroSteps/intro1.dart';
import 'package:lpr/components/widgets/IntroSteps/intro2.dart';
import 'package:lpr/components/widgets/IntroSteps/intro3.dart';
import 'package:lpr/components/widgets/IntroSteps/intro4.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/pages/Login_number.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  GeneralController controller = Get.find();

  List<Widget> pages = [
    const Intro1(),
    const Intro2(),
    const Intro3(),
    Intro4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            const SizedBox(height: Tools.PADDING),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Relais'Ivoire",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .moveY(duration: 400.ms, begin: -25.0, end: 0),
                  Spacer(),
                  if (_currentPageIndex < pages.length - 1)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentPageIndex = pages.length - 1;
                          _pageController.jumpToPage(_currentPageIndex);
                        });
                      },
                      child: Text(
                        "Passer",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.primary),
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                width: Get.size.width,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.5,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        MyColors.secondary, // Couleur extérieure (beige)
                      ],
                      stops: const [
                        0.3,
                        1.0
                      ], // Arrête les proportions de chaque couleur
                    ),
                    border: const Border.symmetric(
                        horizontal: BorderSide.none,
                        vertical: BorderSide.none)),
                child: SizedBox(
                  height: Get.size.height * 3 / 4,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: pages,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Tools.PADDING / 2),
            SizedBox(height: 20, child: WaveInverse()),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: MyColors.primary,
                    border: Border(top: BorderSide.none)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.15,
                      child: Image.asset("assets/images/pattern.png",
                          fit: BoxFit.cover, width: Get.width),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Tools.PADDING * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          pages.length,
                          (index) {
                            if (index != _currentPageIndex) {
                              return GestureDetector(
                                onTap: () {
                                  _pageController.jumpToPage(index);
                                  setState(() {
                                    _currentPageIndex = index;
                                  });
                                },
                                child: const Circle(),
                              );
                            } else if (_currentPageIndex == pages.length - 1) {
                              return MainButton(
                                title: "Commencer",
                                icon: Icons.check,
                                onPressed: () {
                                  if (controller.confirmCGU.value) {
                                    Get.off(
                                      const LoginNumber(),
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeOut,
                                      transition: Transition.rightToLeft,
                                    );
                                  } else {
                                    Tools.showErrorToast(
                                        title: "Vous devez accepter les CGU",
                                        message:
                                            "Veuillez accepter les CGU avant de continuer");
                                  }
                                },
                              ).animate().fadeIn(duration: 1000.ms);
                            } else {
                              return MainButton(
                                title: "Suivant",
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ).animate().fadeIn(duration: 1000.ms);
                            }
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
