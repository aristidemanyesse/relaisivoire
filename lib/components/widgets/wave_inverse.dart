import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class WaveInverse extends StatelessWidget {
  const WaveInverse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.secondary,
          border: Border(
              bottom: BorderSide(
                  color: MyColors.primary.withOpacity(0.5), width: 10))),
      height: double.infinity,
      width: double.infinity,
      // child: WaveWidget(
      //   config: CustomConfig(
      //     gradients: [
      //       [MyColors.primary, MyColors.primary],
      //       [MyColors.primary.withOpacity(0.5), MyColors.primary.withOpacity(0.5)],
      //     ],
      //     durations: [30000, 35000],
      //     heightPercentages: [0.4, 0.23],
      //     gradientBegin: Alignment.bottomCenter,
      //     gradientEnd: Alignment.topCenter,
      //   ),
      //   waveAmplitude: 0,
      //   backgroundColor: MyColors.secondary,
      //   size: const Size(double.infinity, double.infinity),
      // ),
    );
  }
}
