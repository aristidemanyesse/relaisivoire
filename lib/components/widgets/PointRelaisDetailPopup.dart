import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/ScheduleItem.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';

class PointRelaisDetailPopup extends StatelessWidget {
  PointRelaisDetailPopup({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String title;
  final String subtitle;

  CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 550,
        color: MyColors.beige,
        width: double.infinity,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Blur(
                    blur: 5.5,
                    blurColor: Colors.white,
                    child: Image.asset(
                      "assets/images/fascade.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Image.asset(
                    "assets/images/fascade.jpg",
                    fit: BoxFit.contain,
                    height: 200,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(Tools.PADDING),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    size: 80,
                    color: MyColors.bleu,
                  ),
                  SizedBox(width: Tools.PADDING / 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic)),
                        SizedBox(height: Tools.PADDING / 2),
                        Text(
                            "lorem ipsum dolor  In this article, we'll explore some of the best Flutter icon libraries for 2024, including Hugeicons Pro, Material Icons, Feather Icons, and more.",
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScheduleItem(title: "Lun", horaire: "12h-18h"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Mar", horaire: "Fermé"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Mer", horaire: "12h-18h"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Jeu", horaire: "12h-18h"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Ven", horaire: "Fermé"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Sam", horaire: "12h-18h"),
                  Container(height: 20, width: 1, color: Colors.grey),
                  ScheduleItem(title: "Dim", horaire: "12h-18h"),
                ],
              ),
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
                child: MainButtonInverse(
                    title: "Choisir ce point relais ",
                    icon: Icons.check,
                    onPressed: () {
                      _controller.pointRelais.value = id;
                      Get.back();
                    })),
            Spacer(),
            SizedBox(height: 20, child: const Wave()),
          ],
        ),
      ),
    );
  }
}
