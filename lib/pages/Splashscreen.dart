import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/models/ClientApp/Client.dart';
import 'package:relaisivoire/pages/LandingPage.dart';
import 'package:relaisivoire/pages/ListeColisPage.dart';
import 'package:relaisivoire/services/SessionService.dart';
import 'package:relaisivoire/services/StoreService.dart';
import 'package:relaisivoire/services/SyncService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    start();
  }

  void start() async {
    final store = await getStore();
    final sync = SyncService(store: store);
    final session = SessionService(syncService: sync);
    Client? client = await session.restoreOrAuthenticate();
    if (client == null) {
      Get.off(() => LandingPage());
    } else {
      await sync.syncAllData();
      Get.off(() => ListeColisPage());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/images/logo.png', // 🔁 ton logo
                width: 120,
                height: 120,
              ),
              // const SizedBox(height: 10),
              // Text(
              //   "Livrez. Partout. Facilement.",
              //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //         color: MyColors.primary,
              //       ),
              // ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chargement des données...",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: Tools.PADDING),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                child: LinearProgressIndicator(
                  value: null,
                  backgroundColor: Colors.white,
                  color: MyColors.primary,
                ),
              ),
              SizedBox(height: Tools.PADDING * 3),
            ],
          ),
        ),
      ),
    );
  }
}
