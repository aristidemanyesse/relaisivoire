import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:lpr/components/elements/IndicatorPopup.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_icon.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/PurchaseApp/Payement.dart';
import 'package:lpr/pages/ColisPage.dart';
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

  void callback(response, context) {
    switch (response['status']) {
      case PAYMENT_CANCELLED:
        Get.off(ColisPage(colis: widget.colis));
        debugPrint(PAYMENT_CANCELLED);
        break;

      case PAYMENT_INIT:
        debugPrint(PAYMENT_INIT);
        break;

      case PENDING_PAYMENT:
        debugPrint(PENDING_PAYMENT);
        Payement pay = Payement(
            amount: widget.colis.total.toString(),
            transactionId: response['data']['transaction_id'],
            colis: widget.colis,
            status: false);
        pay.save();
        break;

      case PAYMENT_SUCCESS:
        Get.off(ColisPage(colis: widget.colis));
        debugPrint(PAYMENT_SUCCESS);
        debugPrint(response);
        break;

      default:
        debugPrint(UNKNOWN_EVENT);
        break;
    }
  }

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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IndicatorPopup(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                    child: Column(
                      children: [
                        Text(
                          "Confirmation du paiement",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Divider(),
                        const SizedBox(height: Tools.PADDING),
                        Row(
                          children: [
                            const Icon(Icons.qr_code_2_outlined, size: 80),
                            const SizedBox(width: Tools.PADDING / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.colis.getCode(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Par ${widget.colis.sender.target?.fullName()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!),
                                  Text(
                                      "${widget.colis.status.target?.description}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${widget.colis.total - widget.colis.tax} Fcfa",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: MyColors.primary,
                                  fontWeight: FontWeight.bold))
                    ],
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainButtonIcon(
                          onPressed: () {
                            Get.dialog(ConfirmDialog(
                                title: "Confirmation",
                                message:
                                    "Voulez-vous vraiment annuler ce paiement ?",
                                testOk: "Oui, annuler",
                                testCancel: "Non",
                                functionOk: () {
                                  widget.colis.startToPayement = false;
                                  widget.colis.stopPayement();
                                  Get.offAll(ColisPage(colis: widget.colis));
                                },
                                functionCancel: () {
                                  Get.back();
                                }));
                          },
                          icon: Icons.close,
                          color: MyColors.danger,
                        ),
                        MainButtonInverse(
                          title: "Valider le paiement",
                          icon: Icons.check,
                          onPressed: () async {
                            int price = widget.colis.total - widget.colis.tax;
                            if (price < 100 || price > 1500000) {
                              Tools.showErrorToast(
                                  title: "❌ Erreur",
                                  message:
                                      "Le montant du colis doit être compris entre 100 et 1500000 FCFA");
                              return;
                            }
                            final kkiapay = KKiaPay(
                              amount: price, //
                              countries: ["CI"], //
                              phone:
                                  "225${widget.colis.sender.target!.contact}", //
                              name: widget.colis.sender.target?.fullName(), //
                              email: "pay@relais-ivoir.com", //
                              reason:
                                  "Réglement de Frais de livraison Relais'Ivoir", //
                              data: widget.colis.uid, //
                              sandbox: false, //
                              apikey:
                                  "28b9e4e631037b0f1873ebf50e8f79df2c4f4255", //
                              callback: callback, //
                              theme: defaultTheme,
                              callbackUrl: ApiService.NOTIFY_PAYMENT_URL, //
                              partnerId: widget.colis.uid, //
                              paymentMethods: ["momo", "card"], //
                            );

                            Get.dialog(kkiapay);

                            // await Get.to(CinetPayCheckout(
                            //   title:
                            //       'Payement relais ${widget.colis.getCode()}',
                            //   titleStyle: const TextStyle(
                            //       fontSize: 20, fontWeight: FontWeight.bold),
                            //   titleBackgroundColor: MyColors.primary,
                            //   configData: <String, dynamic>{
                            //     'apikey': '188112719167d1898b793959.56072634',
                            //     'site_id': 105889732,
                            //     'mode': 'PRODUCTION',
                            //     'notify_url': ApiService.NOTIFY_PAYMENT_URL,
                            //   },
                            //   paymentData: <String, dynamic>{
                            //     'transaction_id': DateTime.now()
                            //         .millisecondsSinceEpoch
                            //         .toString(),
                            //     'amount': price.toString(),
                            //     'currency': 'XOF',
                            //     'channels': 'ALL',
                            //     'description':
                            //         'Payement relais ${widget.colis.getCode()}',
                            //     'metadata': widget.colis.uid,
                            //   },
                            //   waitResponse: (response) {
                            //     print(response);
                            //   },
                            //   onError: (response) {
                            //     print(response);
                            //   },
                            // ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 30, child: const Wave()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
