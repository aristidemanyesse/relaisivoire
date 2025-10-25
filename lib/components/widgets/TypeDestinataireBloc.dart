import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/controllers/CommandeProcessController.dart';
import 'package:relaisivoire/models/ColisApp/TypeDestinataire.dart';

class TypeDestinataireBloc extends StatelessWidget {
  final TypeDestinataire type;

  TypeDestinataireBloc({super.key, required this.type});

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
            onTap: () {
              _controller.typeDestinataire.value = type;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING / 2,
                vertical: Tools.PADDING / 2,
              ),
              decoration: BoxDecoration(
                color: _controller.typeDestinataire.value == type
                    ? MyColors.primary
                    : MyColors.secondary.withAlpha(200),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  color: MyColors.primary.withOpacity(0.6),
                ),
              ),
              width: double.infinity,
              height: 65,
              child: Row(
                children: [
                  Icon(
                    type.level == 1 ? Icons.person : Icons.person_2_outlined,
                    size: 45,
                    color: _controller.typeDestinataire.value == type
                        ? MyColors.secondary
                        : MyColors.primary,
                  ),
                  const SizedBox(width: Tools.PADDING),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.libelle,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    _controller.typeDestinataire.value == type
                                    ? MyColors.secondary
                                    : MyColors.primary,
                              ),
                        ),
                        const SizedBox(width: Tools.PADDING / 2),
                        Text(
                          type.description ?? "",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color:
                                    _controller.typeDestinataire.value == type
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
    );
  }
}
