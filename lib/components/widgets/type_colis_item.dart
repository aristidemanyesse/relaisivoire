import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/TypeColisDetailPopup.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/models/ColisApp/TypeColis.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeColisItem extends StatelessWidget {
  final TypeColis type;

  TypeColisItem({super.key, required this.type});

  final CommandeProcessController _controller = Get.find();

  void showPopup(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TypeColisDetailPopup(type: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Obx(() {
        return Material(
          color: _controller.typeColis.value == type
              ? MyColors.primary
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              _controller.typeColis.value = type;
            },
            onLongPress: () {
              showPopup(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: MyColors.secondary.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 0.5, color: MyColors.primary.withOpacity(0.6))),
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
                              showPopup(context);
                            },
                            child: Icon(
                              Icons.info,
                              size: 20,
                              color: MyColors.primary,
                            ))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Tools.PADDING / 2),
                      Text(
                        type.icone,
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(type.libelle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
