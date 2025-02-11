import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class OpenQRCode extends StatelessWidget {
  const OpenQRCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text(
          "Scanner le QR code",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyColors.beige, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "qr_code",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Tools.PADDING),
                child: Container(
                  width: Get.width * 0.8,
                  height: Get.width * 0.8,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Tools.PADDING),
            Text(
                "* Faites scaner le QR code par l'agent \ndans le point relais",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!),
          ],
        ),
      ),
    );
  }
}
