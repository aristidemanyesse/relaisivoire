import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/ColisPage.dart';

class ItemBloc extends StatelessWidget {
  final String title;
  final String subtitle;
  final String created;
  final bool received;

  const ItemBloc({
    super.key,
    required this.title,
    required this.subtitle,
    required this.created,
    required this.received,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(ColisPage(received: received),
              transition: Transition.topLevel);
        },
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING,
              vertical: Tools.PADDING / 4,
            ),
            decoration: BoxDecoration(
                color: MyColors.secondary.withAlpha(200),
                border: Border.all(
                    width: 0.5, color: MyColors.textprimary.withOpacity(0.6))),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: (received
                                ? MyColors.textprimary
                                : MyColors.textprimary)),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: (received
                                  ? MyColors.textprimary
                                  : MyColors.textprimary),
                            ),
                      ),
                      Text(
                        created,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: (received
                                    ? MyColors.textprimary
                                    : MyColors.textprimary)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Icon(
                      received ? Icons.inventory_2 : Icons.watch_later_outlined,
                      color:
                          received ? MyColors.success : MyColors.textprimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
