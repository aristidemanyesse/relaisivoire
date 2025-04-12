import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';

class TypeColisDetailPopup extends StatelessWidget {
  final TypeColis type;

  const TypeColisDetailPopup({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: MyColors.secondary,
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
                      type.icone,
                      style: TextStyle(fontSize: 100),
                    ),
                    SizedBox(width: Tools.PADDING),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(type.libelle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: Tools.PADDING / 2),
                          Text(type.description,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: Tools.PADDING / 2),
                          Row(children: [
                            Text("Transport :",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic)),
                            SizedBox(width: Tools.PADDING / 2),
                            Text(
                                "${type.vehicule.target?.libelle} ${type.vehicule.target?.icone}",
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
