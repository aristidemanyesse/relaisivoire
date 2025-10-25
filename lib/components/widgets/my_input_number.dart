import 'package:flutter/material.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class MyInputNumber extends StatelessWidget {
  final int nbPlaces;
  final String value;

  MyInputNumber({super.key, required this.value, required this.nbPlaces});

  List tab = [2, 6];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(nbPlaces, (index) {
        if (index <= value.length - 1) {
          if (tab.contains(index)) {
            return Container(
              padding: const EdgeInsets.only(left: Tools.PADDING / 2),
              child: Container(
                margin: EdgeInsets.only(right: Tools.PADDING / 15),
                child: Text(
                  value[index],
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(right: Tools.PADDING / 15),
              child: Text(
                value[index],
                style: Theme.of(context).textTheme.displayLarge,
              ),
            );
          }
        } else {
          if (tab.contains(index)) {
            return Container(
              padding: const EdgeInsets.only(left: Tools.PADDING / 2),
              margin: EdgeInsets.only(right: Tools.PADDING / 15),
              child: Text("_", style: Theme.of(context).textTheme.displayLarge),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(right: Tools.PADDING / 15),
              child: Text("_", style: Theme.of(context).textTheme.displayLarge),
            );
          }
        }
      }),
    );
  }
}
