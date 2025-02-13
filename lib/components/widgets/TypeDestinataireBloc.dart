import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';

class TypeDestinataireBloc extends StatelessWidget {
  final String id;
  final String subtitle;
  final String title;
  final IconData icon;

  TypeDestinataireBloc({
    super.key,
    required this.id,
    required this.subtitle,
    required this.title,
    required this.icon,
  });

  CommandeProcessController _controller = Get.find();

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
              _controller.typeDestinataire.value = id;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING / 2,
                vertical: Tools.PADDING / 4,
              ),
              decoration: BoxDecoration(
                  color: _controller.typeDestinataire.value == id
                      ? MyColors.bleu
                      : MyColors.beige.withAlpha(200),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5)),
              width: double.infinity,
              height: 65,
              child: Row(
                children: [
                  Icon(icon,
                      size: 45,
                      color: _controller.typeDestinataire.value == id
                          ? MyColors.beige
                          : MyColors.bleu),
                  const SizedBox(
                    width: Tools.PADDING,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _controller.typeDestinataire.value == id
                                            ? MyColors.beige
                                            : MyColors.bleu)),
                        const SizedBox(
                          width: Tools.PADDING / 2,
                        ),
                        Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        _controller.typeDestinataire.value == id
                                            ? MyColors.beige
                                            : MyColors.bleu)),
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
