import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/TypeDestinataireBloc.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/pages/FormulaireContactDestinataire.dart';

class Commander4 extends StatelessWidget {
  Commander4({
    super.key,
  });

  final CommandeProcessController _controller = Get.find();
  final HandleTypesController handleTypesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
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
                      "Qui doit récuperer le colis ?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Coordonnées du destinataire",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyColors.secondary),
                    ),
                  ],
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
            mainAxisSize: MainAxisSize.min,
            children: handleTypesController.listeTypeDestinataires.value
                .map((typeDestinataire) {
              return TypeDestinataireBloc(type: typeDestinataire);
            }).toList(),
          ),
        ),
        Spacer(),
        Obx(() {
          return Visibility(
                  visible: _controller.typeDestinataire.value?.level == 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(),
                      SizedBox(child: FormulaireContactDestinataire()),
                    ],
                  ))
              .animate()
              .fadeIn(duration: 400.ms)
              .moveY(duration: 400.ms, begin: -25.0, end: 0);
        }),
        Obx(() {
          return _controller.typeDestinataire.value?.level == 2
              ? Spacer()
              : Container();
        }),
        const SizedBox(
          height: Tools.PADDING,
        ),
      ],
    );
  }
}
