import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:convert' show utf8;

@Entity()
class Payement {
  int id = 0;

  @Index()
  String uid;

  String amount;
  String transactionId;
  bool status;

  final colis = ToOne<Colis>();

  Payement({
    this.uid = "",
    required this.amount,
    required this.transactionId,
    required this.status,
    Colis? colis,
  });

  factory Payement.fromJson(Map<String, dynamic> json) {
    final payement = Payement(
      uid: json['id'],
      amount: json['amount'],
      transactionId: json['transactionId'],
      status: json['status'],
    );

    if (json['colis'] != null) {
      payement.colis.target = Colis.fromJson(json['type']);
    }
    return payement;
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'transactionId': transactionId,
        'status': status,
        'colis': colis.target?.uid,
      };

  Future<Payement> save() async {
    final data = await ApiService.post('api/payements/', toJson());
    final datas = await ApiService.get("api/payements/${data['data']["id"]}/");
    final pay = Payement.fromJson(datas['data']);
    return pay;
  }
}
