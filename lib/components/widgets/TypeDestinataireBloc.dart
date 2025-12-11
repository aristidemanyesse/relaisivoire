import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/models/ColisApp/TypeDestinataire.dart';

class TypeDestinataireBloc extends StatelessWidget {
  final TypeDestinataire type;
  final bool isCalled;
  TypeDestinataireBloc({super.key, required this.type, this.isCalled = false});

  final CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: Obx(() {
          return InkWell(
            onTap: isCalled
                ? null
                : () {
                    _controller.typeDestinataire.value = type;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING / 2,
                vertical: Tools.PADDING / 4,
              ),
              decoration: BoxDecoration(
                  color: _controller.typeDestinataire.value == type
                      ? MyColors.primary
                      : MyColors.secondary.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5)),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 65),
              child: Row(
                children: [
                  Icon(type.level == 1 ? Icons.person : Icons.person_2_outlined,
                      size: 45,
                      color: _controller.typeDestinataire.value == type
                          ? MyColors.secondary
                          : MyColors.primary),
                  const SizedBox(
                    width: Tools.PADDING,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type.libelle,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _controller.typeDestinataire.value ==
                                            type
                                        ? MyColors.secondary
                                        : MyColors.primary)),
                        const SizedBox(
                          width: Tools.PADDING / 2,
                        ),
                        Text(type.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: _controller.typeDestinataire.value ==
                                            type
                                        ? MyColors.secondary
                                        : MyColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
