import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/models/ColisApp/Colis.dart';
import 'package:relaisivoire/models/ColisApp/StatusColis.dart';
import 'package:relaisivoire/pages/ColisPage.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemBloc extends StatefulWidget {
  final Colis colis;
  final String? tag;

  const ItemBloc({super.key, required this.colis, this.tag = ""});

  @override
  State<ItemBloc> createState() => _ItemBlocState();
}

class _ItemBlocState extends State<ItemBloc> {
  IconData icon = Icons.cancel;
  Color color = Colors.grey;
  bool sent = false;

  @override
  void initState() {
    sent = widget.colis.status.target!.level == StatusColis.LIVRAISON;
    if (widget.colis.status.target!.level == StatusColis.EN_ATTENTE) {
      icon = Icons.watch_later_outlined;
      color = Colors.grey;
    } else if (widget.colis.status.target!.level == StatusColis.DEPOSE) {
      icon = Icons.inventory_2;
      color = MyColors.primary;
    } else if (widget.colis.status.target!.level == StatusColis.ASSIGNATION) {
      icon = Icons.pedal_bike;
      color = MyColors.textprimary;
    } else if (widget.colis.status.target!.level == StatusColis.LIVRAISON) {
      icon = Icons.storefront;
      color = MyColors.textprimary;
    } else if (widget.colis.status.target!.level == StatusColis.RETRAIT) {
      icon = Icons.done_all;
      color = MyColors.success;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(
            ColisPage(colis: widget.colis),
            transition: Transition.topLevel,
          );
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
                width: 0.5,
                color: MyColors.textprimary.withOpacity(0.6),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.colis.getCode(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: (sent
                              ? MyColors.textprimary
                              : MyColors.textprimary),
                        ),
                      ),
                      Text(
                        sent
                            ? widget.colis.pointRelaisReceiver.target
                                      ?.title() ??
                                  ""
                            : widget.colis.title(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: (sent
                              ? MyColors.textprimary
                              : MyColors.textprimary),
                        ),
                      ),
                      Text(
                        timeago.format(
                          widget.colis.dateCreation!,
                          locale: 'fr',
                        ),
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(
                              color: (sent
                                  ? MyColors.textprimary
                                  : MyColors.textprimary),
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        widget.colis.status.target?.libelle ?? "...",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: Tools.PADDING / 3),
                    Icon(icon, color: color),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
