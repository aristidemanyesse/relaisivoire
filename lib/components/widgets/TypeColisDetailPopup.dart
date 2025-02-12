import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';

class TypeColisDetailPopup extends StatelessWidget {
  const TypeColisDetailPopup({
    super.key,
    required this.icon,
    required this.title,
  });

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: MyColors.beige,
        height: 230,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                  height: 30,
                  child: Center(
                      child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)),
                  ))),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      icon,
                      style: TextStyle(fontSize: 100),
                    ),
                    SizedBox(width: Tools.PADDING),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: Tools.PADDING / 2),
                          Text(
                              "lorem ipsum dolor  In this article, we'll explore some of the best Flutter icon libraries for 2024, including Hugeicons Pro, Material Icons, Feather Icons, and more.",
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: Tools.PADDING / 2),
                          Row(children: [
                            Text("Transport par :",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic)),
                            SizedBox(width: Tools.PADDING / 2),
                            Text("Moto 🛵",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30, child: const Wave()),
          ],
        ),
      ),
    );
  }
}
