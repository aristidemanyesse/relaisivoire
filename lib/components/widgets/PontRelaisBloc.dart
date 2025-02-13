import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/PointRelaisDetailPopup.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PontRelaisBloc extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final bool received;

  PontRelaisBloc({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.received,
  });

  final CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Tools.PADDING / 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          color: Colors.transparent,
          child: Material(
            color: Colors.transparent,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => PointRelaisDetailPopup(
                        title: title, subtitle: subtitle, id: id),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Tools.PADDING / 3,
                    vertical: Tools.PADDING / 2,
                  ),
                  decoration: BoxDecoration(
                      color: _controller.pointRelais.value == id
                          ? MyColors.primary
                          : MyColors.secondary.withAlpha(200),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 0.5,
                          color: MyColors.primary.withOpacity(0.6))),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Center(
                        child: Icon(Icons.location_on_sharp,
                            size: 35,
                            color: _controller.pointRelais.value == id
                                ? MyColors.secondary
                                : MyColors.primary),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: _controller.pointRelais.value == id
                                          ? MyColors.secondary
                                          : MyColors.primary),
                            ),
                            Text(
                              subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: _controller.pointRelais.value == id
                                          ? MyColors.secondary
                                          : MyColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
