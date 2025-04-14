import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/pages/Tip.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  HandleTypesController handleTypesController = Get.find();
  final TextEditingController _searchController = TextEditingController();
  List<Colis> displayedList = [];

  @override
  void initState() {
    super.initState();
    displayedList = handleTypesController.historique.value;

    _searchController.addListener(() {
      filterList(_searchController.text);
    });
  }

  void filterList(String query) {
    final filtered = handleTypesController.historique.value.where((colis) {
      final lowerQuery = query.toLowerCase();
      return colis.code.toLowerCase().contains(lowerQuery) ||
          colis.receiverName.toLowerCase().contains(lowerQuery) ||
          colis.receiverPhone.toLowerCase().contains(lowerQuery) ||
          colis.receiverPhone.toLowerCase().contains(lowerQuery) ||
          (colis.pointRelaisSender.target?.libelle
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false) ||
          (colis.pointRelaisReceiver.target?.libelle
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false);
    }).toList();

    setState(() {
      displayedList = filtered;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: TextField(
            controller: _searchController,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tip(
                      text: "Envoyés",
                      icon: Icons.inventory_2,
                      checked: true,
                    ),
                    Tip(text: "Réçus", icon: Icons.local_shipping),
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
                child: displayedList.isNotEmpty
                    ? ListView(
                        children: displayedList
                            .map((colis) => ItemBloc(
                                colis: colis, received: false, tag: ""))
                            .toList())
                    : Center(child: Text("Aucun colis pour le moment")),
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
