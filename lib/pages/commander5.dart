import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/PontRelaisBloc.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';

class Commander5 extends StatelessWidget {
  const Commander5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Get.height * 0.15,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Où doit-il récuperer le colis ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Lieu de récupe",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MyColors.beige),
                ),
                SizedBox(
                  height: Tools.PADDING,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 15.0),
                        scrollPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Rechercher un lieu',
                          hintStyle: TextStyle(
                              fontSize:
                                  15.0), // Taille de la police du hint text réduite
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: MyColors.bleu, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: MyColors.bleu, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(height: 40, child: Wave()),
        SizedBox(height: Tools.PADDING / 2),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(children: [
                    PontRelaisBloc(
                      title: "Boutique de Banbara ",
                      subtitle: "Port-bouët Abattoir",
                      received: false,
                    ),
                    PontRelaisBloc(
                        title: "Boutique Aly",
                        subtitle: "Marcory Anoumabo",
                        received: true),
                    PontRelaisBloc(
                        title: "Boutique Aly",
                        subtitle: "Marcory sans fil",
                        received: true),
                    PontRelaisBloc(
                        title: "Gallerie du parc",
                        subtitle: "Angré II Plateaux vallon",
                        received: true),
                    PontRelaisBloc(
                        title: "ANK Service",
                        subtitle: "Port-bouët Vridi",
                        received: false),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
