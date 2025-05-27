import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:intl/intl.dart';

class ColisCard extends StatefulWidget {
  final Colis colis;
  const ColisCard({
    super.key,
    required this.colis,
  });

  @override
  State<ColisCard> createState() => _ColisCardState();
}

class _ColisCardState extends State<ColisCard> {
  GeneralController controller = Get.find();
  Color color = Colors.white;
  bool forMe = false;

  @override
  void initState() {
    super.initState();
    forMe =
        widget.colis.sender.target?.contact == controller.client.value?.contact;
    if (widget.colis.status.target!.level == StatusColis.EN_ATTENTE) {
      color = Colors.grey;
    } else if (widget.colis.status.target!.level == StatusColis.DEPOSE) {
      color = MyColors.primary;
    } else if (widget.colis.status.target!.level == StatusColis.ASSIGNATION) {
      color = MyColors.textprimary;
    } else if (widget.colis.status.target!.level == StatusColis.LIVRAISON) {
      color = MyColors.textprimary;
    } else if (widget.colis.status.target!.level == StatusColis.RETRAIT) {
      color = MyColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Tools.PADDING / 2,
      ),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2, vertical: Tools.PADDING / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.colis.typeColis.target?.icone}",
                    style: TextStyle(fontSize: 60),
                  ),
                  const SizedBox(width: Tools.PADDING),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.colis.typeColis.target?.libelle}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: MyColors.primary,
                                  fontWeight: FontWeight.bold)),
                      Text(
                          "entre ${widget.colis.typeColis.target?.poids_min} Kg et ${widget.colis.typeColis.target?.poids_max} Kg",
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: Tools.PADDING / 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Tools.PADDING / 2,
                            vertical: Tools.PADDING / 8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            widget.colis.status.target?.description ?? "...",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                      ),
                      SizedBox(height: Tools.PADDING / 4),
                      Text(
                          widget.colis.dateCreation != null
                              ? DateFormat('EEEE dd MMMM yyyy à HH:mm', 'fr')
                                  .format(widget.colis.dateCreation!)
                              : 'Date inconnue',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  )
                ],
              ),
              Divider(),
              const SizedBox(height: Tools.PADDING / 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.inventory_2,
                    size: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: Tools.PADDING / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Niveau d'emballage",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontStyle: FontStyle.italic)),
                        Text(
                            widget.colis.typeEmballage.target?.level == 1
                                ? "Oui bien emballé"
                                : "Non, c'est juste le colis",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Tools.PADDING),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: Tools.PADDING / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Coordonnées du destinataire",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontStyle: FontStyle.italic)),
                        Text(
                            widget.colis.typeDestinataire.target?.level == 1
                                ? "Moi-même (${widget.colis.sender.target?.contact})"
                                : "${widget.colis.receiverName} - ${widget.colis.receiverPhone}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Tools.PADDING),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    size: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: Tools.PADDING / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lieu de Rétrait du colis",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontStyle: FontStyle.italic)),
                        Text(
                            "${widget.colis.pointRelaisReceiver.target?.libelle}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(
                            "${widget.colis.pointRelaisReceiver.target?.adresse()}",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              if (forMe) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.colis.total} Fcfa",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: MyColors.bleunuit)),
                        if (!widget.colis.sold) ...{
                          Text("Total à payer au dépôt",
                              style: Theme.of(context).textTheme.bodyMedium!),
                          Text("(peut changer après validation)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.danger)),
                        } else ...{
                          Text("déjà payé",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.success)),
                        }
                      ],
                    ),
                  ],
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
