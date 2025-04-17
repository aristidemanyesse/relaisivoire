import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/PontRelaisBloc.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/models/PointRelaisApp/PointRelais.dart';

class PointRelaisStep extends StatefulWidget {
  const PointRelaisStep({
    super.key,
  });

  @override
  State<PointRelaisStep> createState() => _PointRelaisStepState();
}

class _PointRelaisStepState extends State<PointRelaisStep> {
  HandleTypesController handleTypesController = Get.find();
  final TextEditingController _searchController = TextEditingController();
  List<PointRelais> displayedList = [];

  @override
  void initState() {
    super.initState();
    displayedList = handleTypesController.listePointsRelais.value;

    _searchController.addListener(() {
      filterList(_searchController.text);
    });
  }

  void filterList(String query) {
    final filtered =
        handleTypesController.listePointsRelais.value.where((point) {
      final lowerQuery = query.toLowerCase();
      return point.libelle.toLowerCase().contains(lowerQuery) ||
          point.adresse().toLowerCase().contains(lowerQuery) ||
          (point.type.target?.libelle.toLowerCase().contains(lowerQuery) ??
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
    return Column(
      children: [
        Container(
          height: 140,
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
                  Text(
                    "Où doit-il récuperer le colis ?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: MyColors.secondary, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Lieu de récupération",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: MyColors.secondary),
                  ),
                  SizedBox(
                    height: Tools.PADDING,
                  ),
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
                            hintText: 'Rechercher un lieu, une zone...',
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
        const SizedBox(height: 20, child: Wave()),
        SizedBox(height: Tools.PADDING),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2,
            ),
            child: SingleChildScrollView(
              child: Column(
                  children: displayedList.map((pointRelais) {
                return PontRelaisBloc(pointRelais: pointRelais);
              }).toList()),
            ),
          ),
        ),
      ],
    );
  }
}
