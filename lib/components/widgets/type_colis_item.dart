import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeColisItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const TypeColisItem({
    super.key,
    required this.icon,
    required this.title,
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.beige.withAlpha(200),
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: 0.5, color: MyColors.bleu.withOpacity(0.6))),
      padding: EdgeInsets.symmetric(horizontal: Tools.PADDING / 4),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 2,
            right: 0,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        backgroundColor: MyColors.beige,
                        builder: (context) => SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
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
                                          )))),
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(Tools.PADDING),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            icon,
                                            style: TextStyle(fontSize: 100),
                                          ),
                                          SizedBox(width: Tools.PADDING),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(title,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                SizedBox(
                                                    height: Tools.PADDING / 2),
                                                Text(
                                                    "lorem ipsum dolor  In this article, we'll explore some of the best Flutter icon libraries for 2024, including Hugeicons Pro, Material Icons, Feather Icons, and more.",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                SizedBox(
                                                    height: Tools.PADDING / 2),
                                                Row(children: [
                                                  Text("Transport par :",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic)),
                                                  SizedBox(
                                                      width: Tools.PADDING / 2),
                                                  Text("Moto 🛵",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20, child: const Wave()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.info,
                      size: 20,
                      color: MyColors.bleu,
                    ))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Tools.PADDING / 2),
              Text(
                icon,
                style: TextStyle(fontSize: 50),
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
