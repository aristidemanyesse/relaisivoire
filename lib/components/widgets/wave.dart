import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class Wave extends StatelessWidget {
  const Wave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.primary,
          border: Border(
              top: BorderSide(width: 0, color: MyColors.primary),
              bottom: BorderSide(
                  color: MyColors.secondary.withOpacity(0.5), width: 10))),
      height: double.infinity,
      width: double.infinity,
      // child: WaveWidget(
      //   config: CustomConfig(
      //     gradients: [
      //       [MyColors.secondary, MyColors.secondary],
      //       [MyColors.secondary.withOpacity(0.5), MyColors.secondary.withOpacity(0.5)],
      //     ],
      //     durations: [30000, 35000],
      //     heightPercentages: [0.4, 0.23],
      //     gradientBegin: Alignment.bottomCenter,
      //     gradientEnd: Alignment.topCenter,
      //   ),
      //   waveAmplitude: 0,
      //   backgroundColor: MyColors.primary,
      //   size: const Size(double.infinity, double.infinity),
      // ),
    );
  }
}
