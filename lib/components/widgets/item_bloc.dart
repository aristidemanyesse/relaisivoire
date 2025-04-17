import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/pages/ColisPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemBloc extends StatelessWidget {
  final Colis colis;
  final String? tag;

  const ItemBloc({
    super.key,
    required this.colis,
    this.tag = "",
  });

  @override
  Widget build(BuildContext context) {
    bool sent = colis.status.target!.level == StatusColis.LIVRAISON;
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(ColisPage(colis: colis, sent: sent),
              transition: Transition.topLevel);
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
                      Text(
                        colis.getCode(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: (sent
                                ? MyColors.textprimary
                                : MyColors.textprimary)),
                      ),
                      Text(
                        sent
                            ? colis.pointRelaisReceiver.target?.title() ?? ""
                            : colis.title(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: (sent
                                  ? MyColors.textprimary
                                  : MyColors.textprimary),
                            ),
                      ),
                      Text(
                        timeago.format(colis.dateCreation!, locale: 'fr'),
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
                  child: Icon(
                      sent ? Icons.inventory_2 : Icons.watch_later_outlined,
                      color: sent ? MyColors.success : MyColors.textprimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
