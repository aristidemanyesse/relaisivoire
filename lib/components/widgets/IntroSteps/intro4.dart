import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:url_launcher/url_launcher.dart';

class Intro4 extends StatelessWidget {
  GeneralController controller = Get.find();

  Intro4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child:
              SvgPicture.asset(
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
                    color: MyColors.textprimary,
                  ),
                ),
                const SizedBox(height: Tools.PADDING / 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Tools.PADDING,
                  ),
                  child: Text(
                    "Ton colis t'attend, récupère le sans stress ni pression.",
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
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Tools.PADDING / 4,
            vertical: Tools.PADDING / 4,
          ),
          margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
          child: Row(
            children: [
              Obx(() {
                return Checkbox(
                  value: controller.confirmCGU.value,
                  activeColor: MyColors.primary,
                  onChanged: (value) {
                    controller.confirmCGU.value = value!;
                  },
                );
              }),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      "Je confirme que j'ai lu et j'accepte les ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                            "https://www.relais-ivoir.com/app/privacy/",
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(
                        "conditions générales et la politique d'utilisation",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
