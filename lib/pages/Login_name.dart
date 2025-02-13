import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';

class LoginName extends StatefulWidget {
  const LoginName({super.key});

  @override
  State<LoginName> createState() => _LoginNameState();
}

class _LoginNameState extends State<LoginName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Get.size.height,
      width: Get.size.width,
      child: Column(
        children: [
          Container(
            height: Get.height * 1 / 3,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            width: Get.size.width,
            decoration: const BoxDecoration(
                color: MyColors.primary,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: Tools.PADDING / 2),
                  Container(
                    height: 70,
                    width: 70,
                    color: Colors.grey,
                  ),
                  Text(
                    "DERNIERE ETAPE",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: MyColors.secondary),
                  ),
                  Text(
                    "Comment vous vous appelez ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: MyColors.secondary),
                  ),
                  const SizedBox(height: Tools.PADDING / 2),
                ],
              ),
            ),
          ),
          const Expanded(flex: 1, child: Wave()),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING * 2, vertical: Tools.PADDING),
              decoration: const BoxDecoration(
                  color: MyColors.secondary,
                  border: Border(top: BorderSide.none)),
              child: Column(
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 30,
                        ),
                        SizedBox(width: Tools.PADDING),
                        Expanded(
                          child: TextField(),
                        ),
                        SizedBox(width: Tools.PADDING),
                      ],
                    ),
                  ),
                  const SizedBox(height: Tools.PADDING * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainButtonInverse(
                          title: "",
                          onPressed: () {
                            Get.back();
                          }),
                      MainButtonInverse(
                          title: "Valider",
                          onPressed: () {
                            // Get.to(const OPTPage());
                          }),
                    ],
                  ),
                  const SizedBox(height: Tools.PADDING),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
