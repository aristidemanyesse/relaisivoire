import 'package:otp_autofill/otp_autofill.dart';

class OTPStrategyService extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'Your code is 5432123',
    );
  }
}
