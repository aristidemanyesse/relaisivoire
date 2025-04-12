import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class Intro3 extends StatelessWidget {
  const Intro3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          "assets/svg/intro3.svg",
          height: Get.size.width * 0.8,
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .moveX(duration: 500.ms, begin: -25.0, end: 0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              "On livre ton colis...",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MyColors.textprimary),
            ),
            const SizedBox(height: Tools.PADDING / 2),
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
            .animate(delay: 500.ms)
            .fadeIn(duration: 500.ms)
            .moveY(duration: 500.ms, begin: 25.0, end: 0),
      ],
    );
  }
}
