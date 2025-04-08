import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lpr/controllers/GeneralController.dart';

class ApiService {
  static const BASE_URL = "http://192.168.1.24:8005/";

  static Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> params) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response =
        await http.post(url, headers: headers, body: json.encode(params));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return {
        "status": true,
        "message": "Ok",
        "data": data,
      };
    } else {
      print(
          "❌ Erreur POST API ${path}: ${response.statusCode} ${response.body}");
      return {
        "status": false,
        "message": "Erreur lors de l'éxecution de la requête",
        "data": null,
      };
    }
  }

  static Future<Map<String, dynamic>> get(String path) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "status": true,
        "message": "Ok",
        "data": data,
      };
    } else {
      print("❌ Erreur GET API ${path}: ${response.statusCode}");
      return {
        "status": false,
        "message": "Erreur lors de l'éxecution de la requête",
        "data": null,
      };
    }
  }
}
