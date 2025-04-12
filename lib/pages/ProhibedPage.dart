import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class ProhibedPage extends StatefulWidget {
  const ProhibedPage({super.key});

  @override
  State<ProhibedPage> createState() => _ProhibedPageState();
}

class _ProhibedPageState extends State<ProhibedPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING * 2),
          decoration: const BoxDecoration(
            color: MyColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.vertical_split_sharp,
                    size: 20,
                  ),
                  Spacer(),
                  Icon(
                    Icons.check,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.secondary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Row(
                    children: [
                      if (_currentPageIndex > 0)
                        Expanded(
                          flex: _currentPageIndex,
                          child: Container(
                            height: 9,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: MyColors.secondary, width: 0.5),
                              color: MyColors.primary.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ).animate().moveX(duration: 400.ms),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.inventory,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0, color: MyColors.primary))),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: 100,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Hello"),
                    subtitle: Text("Hello"),
                  );
                },
              ),
            ),
            SizedBox(height: Tools.PADDING),
            SizedBox(height: Tools.PADDING),
          ],
        ),
      ),
    );
  }
}
