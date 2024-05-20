import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class PoidsBloc extends StatelessWidget {
  const PoidsBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Tools.PADDING / 2),
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Tools.PADDING,
            vertical: Tools.PADDING / 4,
          ),
          decoration: BoxDecoration(
              color: MyColors.beige.withAlpha(200),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1)),
          width: double.infinity,
          height: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Entre", style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    width: Tools.PADDING / 2,
                  ),
                  Text("2 Kg",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  SizedBox(
                    width: Tools.PADDING / 2,
                  ),
                  Text("et", style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    width: Tools.PADDING / 2,
                  ),
                  Text("8 Kg ",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
              Text("Petit colis",
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
