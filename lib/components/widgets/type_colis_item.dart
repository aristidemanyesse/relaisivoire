import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/TypeColisDetailPopup.dart';
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

  void showPopup(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TypeColisDetailPopup(icon: icon, title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          onLongPress: () {
            showPopup(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.beige.withAlpha(200),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 0.5, color: MyColors.bleu.withOpacity(0.6))),
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
          ),
        ),
      ),
    );
  }
}
