import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/colis_page.dart';

class ItemBloc extends StatelessWidget {
  const ItemBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ColisPage());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Tools.PADDING / 2),
        child: Card(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
              vertical: Tools.PADDING / 4,
            ),
            decoration: BoxDecoration(
                color: MyColors.beige.withAlpha(200),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2)),
            width: double.infinity,
            height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2 colis",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                Spacer(
                  flex: 2,
                ),
                Text(
                  "Boutique de Banbara - Port-bouët Abattoir",
                ),
                Spacer(),
                Text("il y a 2 heures",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
