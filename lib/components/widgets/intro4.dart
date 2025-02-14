import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class Intro4 extends StatelessWidget {
  const Intro4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SvgPicture.asset(
            "assets/svg/intro4.svg",
            height: Get.size.width * 0.8,
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .moveX(duration: 500.ms, begin: -25.0, end: 0),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Récupère ton colis.",
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
        const SizedBox(height: Tools.PADDING),
        Container(
          decoration: BoxDecoration(
              color: MyColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 4, vertical: Tools.PADDING / 4),
          margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
          child: Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Expanded(
                child: Wrap(alignment: WrapAlignment.start, children: [
                  Text("Je confirme que j'ai lu et j'accepte les ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  GestureDetector(
                      child: Text("conditions générales",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold))),
                  Text(" et la ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  GestureDetector(
                      child: Text("politique d'utilisation",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold))),
                ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
