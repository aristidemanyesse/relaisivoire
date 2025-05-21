import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';

class ProduitProhibe {
  final String nom;
  final String motif;

  ProduitProhibe({required this.nom, required this.motif});
}

class ProhibedPage extends StatefulWidget {
  const ProhibedPage({super.key});

  @override
  State<ProhibedPage> createState() => _ProhibedPageState();
}

class _ProhibedPageState extends State<ProhibedPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final int _currentPageIndex = 0;

  final List<ProduitProhibe> produitsProhibes = [
    ProduitProhibe(nom: "Armes", motif: "Interdit par la loi"),
    ProduitProhibe(nom: "Drogues", motif: "Produits illégaux"),
    ProduitProhibe(
        nom: "Contrefaçons", motif: "Propriété intellectuelle violée"),
    ProduitProhibe(nom: "Produits explosifs", motif: "Risques de sécurité"),
    ProduitProhibe(
        nom: "Substances chimiques", motif: "Non autorisées au transport"),
    ProduitProhibe(
        nom: "Espèces protégées", motif: "Interdites à l’import/export"),
    ProduitProhibe(
        nom: "Médicaments sans ordonnance", motif: "Vente réglementée"),
    ProduitProhibe(nom: "Liquides inflammables", motif: "Transport dangereux"),
    ProduitProhibe(nom: "Gaz comprimés", motif: "Risque d’explosion"),
    ProduitProhibe(
        nom: "Batteries lithium non conformes", motif: "Risque incendie"),
    ProduitProhibe(nom: "Alcool > 70%", motif: "Réglementation spécifique"),
    ProduitProhibe(
        nom: "Denrées périssables", motif: "Durée de conservation trop courte"),
    ProduitProhibe(
        nom: "Produits surgelés", motif: "Chaîne du froid non garantie"),
    ProduitProhibe(
        nom: "Produits frais non emballés", motif: "Hygiène non assurée"),
    ProduitProhibe(nom: "Objets en verre", motif: "Risque de casse"),
    ProduitProhibe(
        nom: "Objets fragiles non protégés",
        motif: "Casse possible pendant le transport"),
    ProduitProhibe(
        nom: "Bijoux de grande valeur",
        motif: "Responsabilité limitée en cas de perte"),
    ProduitProhibe(
        nom: "Espèces en liquide",
        motif: "Transport interdit pour des raisons légales"),
    ProduitProhibe(nom: "Animaux vivants", motif: "Transport non autorisé"),
    ProduitProhibe(
        nom: "Cendres funéraires", motif: "Nécessite autorisation spécifique"),
    ProduitProhibe(
        nom: "Produits corrosifs",
        motif: "Peuvent endommager les autres colis"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text(
          "Produits Prohibés",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0, color: MyColors.primary))),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: produitsProhibes.length,
                itemBuilder: (context, index) {
                  final produit = produitsProhibes[index];
                  return ListTile(
                    leading: const Icon(Icons.block, color: Colors.red),
                    title: Text(
                      produit.nom,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(produit.motif),
                  );
                },
              ),
            ),
            SizedBox(height: Tools.PADDING),
            MainButtonInverse(
                title: "Ok, compris",
                icon: Icons.chevron_left,
                onPressed: () {
                  Get.back();
                }),
            SizedBox(height: Tools.PADDING * 2),
          ],
        ),
      ),
    );
  }
}
