import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/Tip.dart';
import 'package:lpr/components/widgets/item_bloc.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextField(
            style: TextStyle(fontSize: 15.0),
            scrollPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Rechercher quelque chose',
              hintStyle: TextStyle(
                  fontSize: 15.0), // Taille de la police du hint text réduite
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.primary, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.primary, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30,
              color: MyColors.secondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            const SizedBox(
              height: Tools.PADDING / 2,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Tip(
                      text: "Envoyés",
                      icon: Icons.inventory_2,
                      checked: true,
                    ),
                    Tip(text: "Réçus", icon: Icons.local_shipping),
                    Tip(
                      text: "En cours",
                      icon: Icons.refresh,
                    ),
                    Tip(text: "Terminés", icon: Icons.check),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Tools.PADDING / 4,
            ),
            const SizedBox(
              height: Tools.PADDING,
            ),
            Expanded(
              flex: 10,
              child: SizedBox(
                width: double.infinity,
                child: ListView(children: [
                  ItemBloc(
                    title: "Enveloppe / Porte-document",
                    subtitle: "Boutique de Banbara - Port-bouët Abattoir",
                    created: "il y a 2 min",
                    received: false,
                  ),
                  ItemBloc(
                      title: "Valise gros colis",
                      subtitle: "Boutique Aly - Marcory Anoumabo",
                      created: "il y a 1 heures",
                      received: true),
                  ItemBloc(
                      title: "Valise gros colis",
                      subtitle: "Boutique Aly - Marcory Anoumabo",
                      created: "il y a 1 heures",
                      received: true),
                  ItemBloc(
                      title: "Valise gros colis",
                      subtitle: "Boutique Aly - Marcory Anoumabo",
                      created: "il y a 1 heures",
                      received: true),
                  ItemBloc(
                      title: "Carton moyen",
                      subtitle: "ANK Service - Port-bouët Vridi",
                      created: "il y a 2 heures",
                      received: false),
                ]),
              ),
            ),
            Container(
              color: MyColors.secondary,
              height: Get.height / 10,
            ),
          ],
        ),
      ),
    );
  }
}
