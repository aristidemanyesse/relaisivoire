import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/poids_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';

class Commander2 extends StatelessWidget {
  Commander2({
    super.key,
  });

  CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.primary,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Quel poids ça fait environ ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.secondary),
                ),
                Text(
                  "Poids de colis",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MyColors.secondary),
                ),
              ],
            )),
        const Expanded(flex: 1, child: Wave()),
        Expanded(
          flex: 10,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: Tools.PADDING,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const PoidsBloc(),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
