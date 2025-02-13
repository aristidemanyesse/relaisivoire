import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class MyInputNumber extends StatelessWidget {
  final int nbPlaces;
  final String value;

  MyInputNumber({super.key, required this.value, required this.nbPlaces});

  List tab = [2, 6];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.phone_android,
          size: 30,
        ),
        const SizedBox(width: Tools.PADDING),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(nbPlaces, (index) {
              if (index <= value.length - 1) {
                if (tab.contains(index)) {
                  return Container(
                      padding: const EdgeInsets.only(left: Tools.PADDING / 2),
                      child: Text(value[index],
                          style: Theme.of(context).textTheme.displayLarge));
                } else {
                  return Text(value[index],
                      style: Theme.of(context).textTheme.displayLarge);
                }
              } else {
                if (tab.contains(index)) {
                  return Container(
                    padding: const EdgeInsets.only(left: Tools.PADDING / 2),
                    child: Text("_",
                        style: Theme.of(context).textTheme.displayLarge),
                  );
                } else {
                  return Text("_",
                      style: Theme.of(context).textTheme.displayLarge);
                }
              }
            }),
          ),
        ),
      ],
    );
  }
}
