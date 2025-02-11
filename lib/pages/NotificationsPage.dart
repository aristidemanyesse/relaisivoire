
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/NotificationItem.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';
import 'package:lpr/controllers/keyboard_controller.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications (22)",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: MyColors.beige,
                )),
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Container(
              height: 10,
              color: MyColors.bleu,
            ),
            Expanded(
              flex: 10,
              child: SizedBox(
                width: double.infinity,
                child: ListView(
                    children: List.generate(18, (index) {
                  return NotificationItem(
                    title: "Enveloppe / Porte-document",
                    subtitle: "Boutique de Banbara - Port-bouët Abattoir",
                    created: "il y a 2 min",
                    received: false,
                  );
                })),
              ),
            ),
            Container(
              color: MyColors.beige,
              height: 10,
            ),
            SizedBox(height: 50, child: const WaveInverse()),
            Container(
              color: MyColors.bleu,
              padding: const EdgeInsets.only(bottom: Tools.PADDING / 2),
            ),
          ],
        ),
      ),
    );
  }
}
