import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/pages/ColisPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoriqueBloc extends StatelessWidget {
  final Colis colis;
  final String? tag;

  HistoriqueBloc({
    super.key,
    required this.colis,
    this.tag = "",
  });

  GeneralController controller = Get.find();

  String formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    bool sent =
        colis.sender.target!.contact == controller.client.value!.contact;
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(ColisPage(colis: colis), transition: Transition.topLevel);
        },
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
              vertical: Tools.PADDING / 4,
            ),
            decoration: BoxDecoration(
                color: MyColors.secondary.withAlpha(200),
                border: Border.all(
                    width: 0.5, color: MyColors.textprimary.withOpacity(0.6))),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            colis.getCode(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: (sent
                                        ? MyColors.textprimary
                                        : MyColors.textprimary)),
                          ),
                          SizedBox(width: Tools.PADDING / 2),
                          Text(
                            "${colis.typeColis.target?.libelle}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: (sent
                                        ? MyColors.textprimary
                                        : MyColors.textprimary)),
                          )
                        ],
                      ),
                      colis.status.target?.level == StatusColis.ANNULE
                          ? Text(
                              "Annulé",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: MyColors.danger),
                            )
                          : Text(
                              sent
                                  ? "Déposé chez ${colis.pointRelaisSender.target?.title()}"
                                  : "Reçu chez ${colis.pointRelaisReceiver.target?.title()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: (sent
                                        ? MyColors.textprimary
                                        : MyColors.textprimary),
                                  ),
                            ),
                      SizedBox(height: Tools.PADDING / 4),
                      Text(
                        formatDate(colis.dateCreation!),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: (sent
                                    ? MyColors.textprimary
                                    : MyColors.textprimary)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Icon(sent ? Icons.delivery_dining : Icons.inventory_2,
                      color: sent ? MyColors.textprimary : MyColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
