import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/circle_indicator.dart';
import 'package:lpr/components/elements/barre.dart';
import 'package:lpr/pages/commander1.dart';
import 'package:lpr/pages/commander2.dart';
import 'package:lpr/pages/commander3.dart';
import 'package:lpr/pages/commander4.dart';
import 'package:lpr/pages/commander5.dart';
import 'package:lpr/pages/commander6.dart';

class CommanderPage extends StatefulWidget {
  const CommanderPage({Key? key}) : super(key: key);

  @override
  State<CommanderPage> createState() => _CommanderPageState();
}

class _CommanderPageState extends State<CommanderPage> {
  final PageController _controller = PageController();

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
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: Tools.PADDING * 2),
              decoration: const BoxDecoration(
                color: MyColors.bleu,
              ),
              child: const Row(
                children: [
                  CircleIndicator(text: "1"),
                  Barre(),
                  CircleIndicator(text: "2"),
                  Barre(),
                  CircleIndicator(text: "3"),
                  Barre(),
                  CircleIndicator(text: "4"),
                  Barre(),
                  CircleIndicator(text: "5"),
                  Barre(),
                  CircleIndicator(text: "6"),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                children: const [
                  Commander1(),
                  Commander2(),
                  Commander3(),
                  Commander4(),
                  Commander5(),
                  Commander6(),
                ],
              ),
            ),
            SizedBox(
              height: Get.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButtonInverse(
                      title: "Suivant",
                      onPressed: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutBack);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
