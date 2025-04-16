import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/models/ClientApp/NotificationClient.dart';

class NotificationItem extends StatelessWidget {
  final NotificationClient notification;

  const NotificationItem({super.key, required this.notification});

  String formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Get.dialog(
            ConfirmDialog(
              title: notification.title,
              message: notification.message,
              testOk: "Ok, j'ai compris !",
              testCancel: null,
              functionOk: () async {
                bool res = await notification.readIt();
                if (res) {
                  Get.back();
                }
              },
              functionCancel: () {
                Get.back();
              },
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
              vertical: Tools.PADDING / 4,
            ),
            decoration: BoxDecoration(
                color: MyColors.secondary.withAlpha(200),
                border: Border.all(
                    width: 0.5, color: MyColors.primary.withOpacity(0.6))),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: (notification.read
                                ? MyColors.bleunuit
                                : MyColors.primary)),
                      ),
                      Text(
                        notification.message,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: (notification.read
                                  ? MyColors.bleunuit
                                  : MyColors.primary),
                            ),
                      ),
                      SizedBox(height: Tools.PADDING / 4),
                      Text(
                        formatDate(notification.date_creation),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontWeight: FontWeight.w300,
                                color: (notification.read
                                    ? MyColors.bleunuit
                                    : MyColors.primary)),
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
