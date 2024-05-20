import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/pages/commander.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Login_name.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/elements/prefix.dart';
import 'package:lpr/components/widgets/wave.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ParametrePage());
            },
            icon: Icon(Icons.settings)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Container(
              height: Get.height / 8,
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              width: Get.size.width,
              decoration: const BoxDecoration(
                  color: MyColors.bleu,
                  border: Border.symmetric(
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bonjour,",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: MyColors.beige),
                    ),
                    Text(
                      "Jacques",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: MyColors.beige),
                    ),
                  ],
                ),
              ),
            ),
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
                    SizedBox(
                      height: Tools.PADDING,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              2,
                              (index) => ItemBloc(),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: MyColors.beige,
              height: Get.height / 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CommanderPage());
        },
        child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: MyColors.bleu,
            ),
            child: Icon(Icons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
