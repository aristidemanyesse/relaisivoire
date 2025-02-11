import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/ScheduleItem.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/pages/ColisPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PontRelaisBloc extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool received;

  const PontRelaisBloc({
    super.key,
    required this.title,
    required this.subtitle,
    required this.received,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Tools.PADDING / 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              backgroundColor: MyColors.beige,
              builder: (context) => SizedBox(
                height: 500,
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
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
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
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
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Tools.PADDING / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ScheduleItem(title: "Lun", horaire: "12h-18h"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Mar", horaire: "Fermé"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Mer", horaire: "12h-18h"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Jeu", horaire: "12h-18h"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Ven", horaire: "Fermé"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Sam", horaire: "12h-18h"),
                              Container(
                                  height: 20, width: 1, color: Colors.grey),
                              ScheduleItem(title: "Dim", horaire: "12h-18h"),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Tools.PADDING / 3),
                            child: MainButtonInverse(
                                title:
                                    "Choisir ce point relais pour \nrécupérer le colis",
                                onPressed: () {
                                  Get.back();
                                })),
                        Spacer(),
                        SizedBox(height: 20, child: const Wave()),
                      ],
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: MyColors.bleu,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 3,
              vertical: Tools.PADDING / 4,
            ),
            decoration: BoxDecoration(
                color: MyColors.beige.withAlpha(200),
                border: Border.all(
                    width: 0.5, color: MyColors.bleu.withOpacity(0.6))),
            width: double.infinity,
            child: Row(
              children: [
                Center(
                  child: Icon(Icons.location_on_sharp,
                      size: 45, color: MyColors.bleu),
                ),
                SizedBox(width: Tools.PADDING / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: (received ? MyColors.bleu : MyColors.bleu)),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: (received ? MyColors.bleu : MyColors.bleu),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
