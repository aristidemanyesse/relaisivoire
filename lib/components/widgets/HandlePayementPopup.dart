import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/services/ApiService.dart';

class HandlePayementPopup extends StatefulWidget {
  final Colis colis;
  const HandlePayementPopup({
    required this.colis,
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
                  if (widget.colis.total < 100 ||
                      widget.colis.total > 1500000) {
                    Tools.showErrorToast(
                        title: "❌ Erreur",
                        message:
                            "Le montant du colis doit être compris entre 100 et 1500000 FCFA");
                    return;
                  }
                  await Get.to(CinetPayCheckout(
                    title: 'Payement relais ${widget.colis.getCode()}',
                    titleStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    titleBackgroundColor: MyColors.primary,
                    configData: <String, dynamic>{
                      'apikey': '73092911067edb3711819f3.83413847',
                      'site_id': 105891282,
                      'mode': 'PRODUCTION',
                      'notify_url': ApiService.NOTIFY_PAYMENT_URL,
                    },
                    paymentData: <String, dynamic>{
                      'transaction_id':
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      'amount': widget.colis.total.toString(),
                      'currency': 'XOF',
                      'channels': 'ALL',
                      'description':
                          'Payement relais ${widget.colis.getCode()}',
                      'metadata': widget.colis.uid,
                    },
                    waitResponse: (data) {
                      if (mounted) {
                        setState(() {
                          print(data);
                          Get.back();
                        });
                      }
                    },
                    onError: (data) {
                      if (mounted) {
                        setState(() {
                          response = data;
                          print(data);
                          Get.back();
                        });
                      }
                    },
                  ));
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
