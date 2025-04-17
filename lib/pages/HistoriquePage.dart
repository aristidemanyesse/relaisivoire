import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/historique_bloc.dart';
import 'package:lpr/controllers/ColisController.dart';
import 'package:lpr/controllers/GeneralController.dart';
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
  ColisController colisController = Get.find();
  GeneralController controller = Get.find();

  final TextEditingController _searchController = TextEditingController();
  List<Colis> displayedList = [];

  String tip = "Tous";

  @override
  void initState() {
    super.initState();
    displayedList = colisController.historique.value;

    _searchController.addListener(() {
      filterList(_searchController.text);
    });
  }

  void filterList(String query) {
    List<Colis> filtered = colisController.historique.value.where((colis) {
      final lowerQuery = query.toLowerCase();
      return colis.code.toLowerCase().contains(lowerQuery) ||
          colis.receiverName.toLowerCase().contains(lowerQuery) ||
          colis.receiverPhone.toLowerCase().contains(lowerQuery) ||
          (colis.pointRelaisSender.target?.libelle
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false) ||
          (colis.pointRelaisSender.target
                  ?.adresse()
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false) ||
          (colis.pointRelaisReceiver.target
                  ?.adresse()
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false) ||
          (colis.pointRelaisReceiver.target?.libelle
                  .toLowerCase()
                  .contains(lowerQuery) ??
              false);
    }).toList();

    if (tip == "Déposés") {
      filtered = filtered.where((colis) {
        return colis.sender.target?.contact == controller.client.value!.contact;
      }).toList();
    } else if (tip == "Récupérés") {
      filtered = filtered.where((colis) {
        return colis.receiver.target?.contact ==
            controller.client.value!.contact;
      }).toList();
    }

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
        backgroundColor: MyColors.primary,
        title: Text(
          "Mon historique",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: Get.size.width,
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              decoration: const BoxDecoration(
                  color: MyColors.primary,
                  border: Border.symmetric(
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.15,
                    child: Image.asset("assets/images/pattern.png",
                        fit: BoxFit.cover, width: Get.width),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(fontSize: 15.0),
                              scrollPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText:
                                    'Rechercher par code, lieu, type de colis...',
                                hintStyle: TextStyle(
                                    fontSize:
                                        15.0), // Taille de la police du hint text réduite
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.primary, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyColors.primary, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Tools.PADDING / 2,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: Tools.PADDING / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Tip(
                    text: "Tous",
                    checked: tip == "Tous",
                    onTap: () => setState(() {
                      tip = "Tous";
                      filterList(_searchController.text);
                    }),
                  ),
                  Tip(
                    text: "Déposés",
                    checked: tip == "Déposés",
                    onTap: () => setState(() {
                      tip = "Déposés";
                      filterList(_searchController.text);
                    }),
                  ),
                  Tip(
                    text: "Récupérés",
                    checked: tip == "Récupérés",
                    onTap: () => setState(() {
                      tip = "Récupérés";
                      filterList(_searchController.text);
                    }),
                  ),
                  Spacer(),
                  Text("${displayedList.length} colis",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
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
                            .map((colis) =>
                                HistoriqueBloc(colis: colis, tag: ""))
                            .toList())
                    : Center(child: Text("Aucun historique pour le moment")),
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
