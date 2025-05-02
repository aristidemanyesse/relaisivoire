
import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/pages/PleaseWait2.dart';

class HandlePayementPopup extends StatefulWidget {
  const HandlePayementPopup({
    super.key,
  });

  @override
  State<HandlePayementPopup> createState() => _HandlePayementPopupState();
}

class _HandlePayementPopupState extends State<HandlePayementPopup> {
  TextEditingController amountController = TextEditingController();
  Map<String, dynamic>? response;
  Color? color;
  IconData? icon;
  String? message;
  bool show = false;

  final GeneralController generalController = Get.find();
  final CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 350,
        color: MyColors.secondary,
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text("Espace pour la gestion du paiement",
                style: Theme.of(context).textTheme.titleSmall!),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
              child: MainButtonInverse(
                title: "Valider le paiement",
                icon: Icons.check,
                onPressed: () async {
                  int amount = 1000;
                  if (amount < 100 || amount > 1500000) {
                    // Mettre une alerte
                    return;
                  }

                  await Get.to(CinetPayCheckout(
                    title: 'Payment Checkout',
                    titleStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    titleBackgroundColor: Colors.green,
                    configData: <String, dynamic>{
                      'apikey': 'API_KEY',
                      'site_id': 2, //int.parse("YOUR_SITE_ID"),
                      'notify_url': 'YOUR_NOTIFY_URL'
                    },
                    paymentData: <String, dynamic>{
                      'transaction_id': "transactionId",
                      'amount': amount.toString(),
                      'currency': 'XOF',
                      'channels': 'ALL',
                      'description': 'Payment test',
                    },
                    waitResponse: (data) {
                      if (mounted) {
                        setState(() {
                          response = data;
                          print(response);
                          icon = data['status'] == 'ACCEPTED'
                              ? Icons.check_circle
                              : Icons.mood_bad_rounded;
                          color = data['status'] == 'ACCEPTED'
                              ? Colors.green
                              : Colors.redAccent;
                          show = true;
                          Get.back();
                        });
                      }
                    },
                    onError: (data) {
                      if (mounted) {
                        setState(() {
                          response = data;
                          message = response!['description'];
                          print(response);
                          icon = Icons.warning_rounded;
                          color = Colors.yellowAccent;
                          show = true;
                          Get.back();
                        });
                      }
                    },
                  ));
                  Get.dialog(PleaseWait2());

                  _controller.create();
                },
              ),
            ),
            SizedBox(height: Tools.PADDING * 2),
            SizedBox(height: 30, child: const Wave()),
          ],
        ),
      ),
    );
  }
}
