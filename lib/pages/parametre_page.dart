import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Login_name.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/elements/prefix.dart';
import 'package:lpr/components/widgets/wave.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({Key? key}) : super(key: key);

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.beige,
        title: Text(
          "Paramètres",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: MyColors.bleu,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING,
                ),
                child: ListView(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Histoiriques",
                          style: Theme.of(context).textTheme.bodyLarge),
                      subtitle: Text("Toutes mes activités",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                )),
          ),
          Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  WaveInverse(),
                  Container(
                    padding: EdgeInsets.only(bottom: Tools.PADDING / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Le Point Relais",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: MyColors.beige)),
                              Spacer(),
                              Text("Version 1.0.0.1502",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: MyColors.beige)),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Conditons générales",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: MyColors.beige)),
                                  SizedBox(
                                    width: Tools.PADDING,
                                    child: Center(
                                        child: Text("|",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: MyColors.beige))),
                                  ),
                                  Text("Politique d'utilisation",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: MyColors.beige)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
