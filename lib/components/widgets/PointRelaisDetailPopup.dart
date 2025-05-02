import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/ScheduleItem.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';
import 'package:lpr/pages/ItineraireMapPage.dart';

class PointRelaisDetailPopup extends StatelessWidget {
  final PointRelais pointRelais;
  final bool map;

  PointRelaisDetailPopup(
      {super.key, required this.pointRelais, this.map = false});

  final CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 600,
        color: MyColors.secondary,
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: 50,
                        color: MyColors.primary,
                      ),
                      SizedBox(width: Tools.PADDING / 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(pointRelais.libelle,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text(pointRelais.adresse(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Tools.PADDING / 2),
                  Text(pointRelais.description ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: Tools.PADDING,
                spacing: Tools.PADDING * 1.5,
                children: pointRelais.schedules.map((schedule) {
                  return ScheduleItem(schedule: schedule);
                }).toList(),
              ),
            ),
            Spacer(),
            map
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
                    child: MainButtonInverse(
                        title: "Localiser sur la carte  ",
                        icon: Icons.map,
                        onPressed: () {
                          Get.to(ItineraireMapPage(pointRelais: pointRelais));
                        }))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
                    child: MainButtonInverse(
                        title: "Choisir ce point relais ",
                        icon: Icons.check,
                        onPressed: () {
                          _controller.pointRelais.value = pointRelais;
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
