import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/widgets/intro1.dart';
import 'package:lpr/components/widgets/intro2.dart';
import 'package:lpr/components/widgets/intro3.dart';
import 'package:lpr/components/widgets/intro4.dart';
import 'package:lpr/pages/Login_number.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  List<Widget> pages = [
    const Intro1(),
    const Intro2(),
    const Intro3(),
    const Intro4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Get.size.height,
      width: Get.size.width,
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              width: Get.size.width,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.5,
                    colors: [
                      MyColors.white.withOpacity(0.15),
                      MyColors.beige, // Couleur extérieure (beige)
                    ],
                    stops: const [
                      0.3,
                      1.0
                    ], // Arrête les proportions de chaque couleur
                  ),
                  border: const Border.symmetric(
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: Tools.PADDING),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BONJOUR",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              "Le Point Relais",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .moveY(duration: 400.ms, begin: -25.0, end: 0),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: Get.size.height * 3 / 5,
                      ),
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
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: WaveInverse()),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                  color: MyColors.bleu, border: Border(top: BorderSide.none)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: Tools.PADDING * 2),
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
                          onPressed: () {
                            Get.to(
                              const LoginNumber(),
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeOut,
                              transition: Transition.downToUp,
                            );
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
            ),
          ),
        ],
      ),
    ));
  }
}
