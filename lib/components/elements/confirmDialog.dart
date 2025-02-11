import 'package:flutter/material.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String testOk;
  final String testCancel;
  final Function functionOk;
  final Function functionCancel;

  const ConfirmDialog(
      {super.key,
      this.title = "😩😟 Hhmmm !",
      this.message = "Voulez-vous vraiment continuer ?",
      this.testOk = "Oui",
      this.testCancel = "Non",
      required this.functionOk,
      required this.functionCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white.withOpacity(0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      color: MyColors.bleu,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, height: 1.5, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          child: MainButtonInverse(
                              title: testOk,
                              onPressed: () {
                                functionOk();
                              })),
                      Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          child: MainButton(
                            onPressed: () {
                              functionCancel();
                            },
                            title: testCancel,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
