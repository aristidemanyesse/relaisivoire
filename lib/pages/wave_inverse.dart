import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveInverse extends StatelessWidget {
  const WaveInverse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide.none)),
      height: double.infinity,
      width: double.infinity,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [MyColors.bleu, MyColors.bleu],
            [MyColors.bleu.withOpacity(0.5), MyColors.bleu.withOpacity(0.5)],
          ],
          durations: [30000, 35000],
          heightPercentages: [0.4, 0.23],
          gradientBegin: Alignment.bottomCenter,
          gradientEnd: Alignment.topCenter,
        ),
        waveAmplitude: 0,
        backgroundColor: MyColors.beige,
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }
}
