import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/controllers/CommandeProcessController.dart';
import 'package:relaisivoire/models/ColisApp/TypeEmballage.dart';

class EmballageBloc extends StatelessWidget {
  final String id;
  final String subtitle;
  final String title;
  final IconData icon;
  final TypeEmballage typeEmballage;

  EmballageBloc({
    super.key,
    required this.id,
    required this.subtitle,
    required this.title,
    required this.icon,
    required this.typeEmballage,
  });

  final CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 1,
        color: Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: Obx(() {
            return InkWell(
              onTap: () {
                _controller.typeEmballage.value = typeEmballage;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING / 2,
                  vertical: Tools.PADDING / 2,
                ),
                decoration: BoxDecoration(
                  color: _controller.typeEmballage.value == typeEmballage
                      ? MyColors.primary
                      : MyColors.secondary.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 0.5,
                    color: MyColors.primary.withOpacity(0.6),
                  ),
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 45,
                      color: _controller.typeEmballage.value == typeEmballage
                          ? MyColors.secondary
                          : MyColors.primary,
                    ),
                    const SizedBox(width: Tools.PADDING),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _controller.typeEmballage.value ==
                                          typeEmballage
                                      ? MyColors.secondary
                                      : MyColors.primary,
                                ),
                          ),
                          const SizedBox(width: Tools.PADDING / 2),
                          Text(
                            subtitle,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color:
                                      _controller.typeEmballage.value ==
                                          typeEmballage
                                      ? MyColors.secondary
                                      : MyColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
