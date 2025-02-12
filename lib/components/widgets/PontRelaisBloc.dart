import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/PointRelaisDetailPopup.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PontRelaisBloc extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool received;

  const PontRelaisBloc({
    super.key,
    required this.title,
    required this.subtitle,
    required this.received,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) =>
                  PointRelaisDetailPopup(title: title, subtitle: subtitle),
            );
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING / 3,
                vertical: Tools.PADDING / 2,
              ),
              decoration: BoxDecoration(
                  color: MyColors.beige.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 0.5, color: MyColors.bleu.withOpacity(0.6))),
              width: double.infinity,
              child: Row(
                children: [
                  Center(
                    child: Icon(Icons.location_on_sharp,
                        size: 35, color: MyColors.bleu),
                  ),
                  SizedBox(width: Tools.PADDING / 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: (received
                                      ? MyColors.bleu
                                      : MyColors.bleu)),
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    (received ? MyColors.bleu : MyColors.bleu),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
