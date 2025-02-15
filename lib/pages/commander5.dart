import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/PontRelaisBloc.dart';
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
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Lieu de récupe",
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
                        const Expanded(
                          child: TextField(
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
            )),
        const SizedBox(height: 20, child: Wave()),
        SizedBox(height: Tools.PADDING),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2,
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                PontRelaisBloc(
                  id: "1",
                  title: "Boutique de Banbara ",
                  subtitle: "Port-bouët Abattoir",
                  received: false,
                ),
                PontRelaisBloc(
                    id: "2",
                    title: "Boutique Aly",
                    subtitle: "Marcory Anoumabo",
                    received: true),
                PontRelaisBloc(
                    id: "3",
                    title: "Boutique Aly",
                    subtitle: "Marcory sans fil",
                    received: true),
                PontRelaisBloc(
                    id: "4",
                    title: "Gallerie du parc",
                    subtitle: "Angré II Plateaux vallon",
                    received: true),
                PontRelaisBloc(
                    id: "5",
                    title: "ANK Service",
                    subtitle: "Port-bouët Vridi",
                    received: false),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
