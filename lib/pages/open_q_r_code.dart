import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OpenQRCode extends StatelessWidget {
  final Colis colis;

  const OpenQRCode({super.key, required this.colis});

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
        centerTitle: true,
        title: Text(
          "Scanner le QR code",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              colis.getCode(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold, color: MyColors.primary),
            ),
            Spacer(),
            Hero(
              tag: "qr_code",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Tools.PADDING / 2),
                child: Container(
                  padding: const EdgeInsets.all(Tools.PADDING),
                  color: Colors.white,
                  child: QrImageView(
                      data: colis.code, version: QrVersions.auto, size: 300),
                ),
              ),
            ),
            Spacer(flex: 2),
            Text(
                "* Faites scaner le QR code par l'agent \ndans le point relais",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
