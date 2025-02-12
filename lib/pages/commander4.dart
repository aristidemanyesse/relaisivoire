import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/TypeDestinataireBloc.dart';
import 'package:lpr/components/widgets/emballage_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/pages/FormulaireContactDestinataire.dart';

class Commander4 extends StatelessWidget {
  const Commander4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Qui doit récuperer le colis ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyColors.beige, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Coordonnées du destinataire",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: MyColors.beige),
                ),
              ],
            )),
        const SizedBox(height: 20, child: Wave()),
        SizedBox(
          height: Tools.PADDING,
        ),
        Spacer(),
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Tools.PADDING,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TypeDestinataireBloc(
                  title: "Moi-même",
                  subtitle: "oui parfaitement emballé, bien scéllé.",
                  icon: Icons.person,
                ),
                TypeDestinataireBloc(
                  title: "Quelqu'un d'autre",
                  subtitle: "C'est pas vraiment emballé mais ça va.",
                  icon: Icons.person_2_outlined,
                ),
              ]),
        ),
        Spacer(),
        Visibility(
                visible: false,
                child: SizedBox(
                    height: 300, child: FormulaireContactDestinataire()))
            .animate()
            .fadeIn(duration: 400.ms)
            .moveY(duration: 400.ms, begin: -25.0, end: 0),
        const SizedBox(
          height: Tools.PADDING * 2,
        ),
      ],
    );
  }
}
