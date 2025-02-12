import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class Intro1 extends StatelessWidget {
  const Intro1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          "assets/svg/intro1.svg",
          height: Get.size.width * 0.8,
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 400.ms)
            .moveX(duration: 400.ms, begin: -25.0, end: 0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Enregistre ton colis ...",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MyColors.bleu),
            ),
            const SizedBox(height: Tools.PADDING),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
            .animate(delay: 1000.ms)
            .fadeIn(duration: 400.ms)
            .moveY(duration: 400.ms, begin: 25.0, end: 0),
      ],
    );
  }
}
