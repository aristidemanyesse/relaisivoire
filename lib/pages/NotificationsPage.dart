import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/widgets/NotificationItem.dart';
import 'package:relaisivoire/components/widgets/wave_inverse.dart';
import 'package:relaisivoire/controllers/NotificationController.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  NotificationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          return Text(
            "Notifications (${controller.notReads.value.length})",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: MyColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Container(height: 10, color: MyColors.primary),
            Expanded(
              flex: 10,
              child: SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return controller.notifications.value.isNotEmpty
                      ? ListView(
                          children: controller.notifications.value.map((
                            notification,
                          ) {
                            return NotificationItem(notification: notification);
                          }).toList(),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Aucune notification pour le moment",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: MyColors.textprimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: Tools.PADDING),
                              MainButtonInverse(
                                title: "Ok, compris",
                                icon: Icons.done_all,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                }),
              ),
            ),
            Container(color: MyColors.secondary, height: 10),
            SizedBox(height: 50, child: const WaveInverse()),
            Container(
              color: MyColors.primary,
              padding: const EdgeInsets.only(bottom: Tools.PADDING / 2),
            ),
          ],
        ),
      ),
    );
  }
}
