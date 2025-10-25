import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lpr/controllers/GeneralController.dart';

class ApiService {
  static const BASE_URL = "https://back.admin.relais-ivoir.com/";
  // static const BASE_URL = "http://192.168.1.2:8000/";
  static const NOTIFY_PAYMENT_URL =
      "${BASE_URL}api/payement/colis_payement_notify/";

  static Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> params) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'utf-8',
    };
    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response =
        await http.post(url, headers: headers, body: json.encode(params));

    final decoded = utf8.decode(response.bodyBytes); // 🔥 forcé en UTF-8
    final Map<String, dynamic> data = json.decode(decoded);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "status": !data.containsKey('error'),
        "message": data.containsKey('error') ? data["error"] : "",
        "data": data.containsKey('error') ? null : data,
      };
    } else {
      print("❌ Erreur POST $path: ${response.statusCode} ${response.body}");
      return {
        "status": false,
        "message": data["error"] ?? "Erreur inconnue",
        "data": null,
      };
    }
  }

  static Future<Map<String, dynamic>> patch(
      String path, Map<String, dynamic> params) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'utf-8',
    };
    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response =
        await http.patch(url, headers: headers, body: json.encode(params));

    final decoded = utf8.decode(response.bodyBytes); // 🔥 forcé en UTF-8
    final Map<String, dynamic> data = json.decode(decoded);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "status": !data.containsKey('error'),
        "message": data.containsKey('error') ? data["error"] : "",
        "data": data.containsKey('error') ? null : data,
      };
    } else {
      print("❌ Erreur POST $path: ${response.statusCode} ${response.body}");
      return {
        "status": false,
        "message": data["error"] ?? "Erreur inconnue",
        "data": null,
      };
    }
  }

  static Future<List<dynamic>> getAll(String path) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'utf-8',
    };

    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response = await http.get(url, headers: headers);
    final decoded = utf8.decode(response.bodyBytes); // 🔥 forcé en UTF-8
    final List<dynamic> data = json.decode(decoded);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      print("❌ Erreur GET $path: ${response.statusCode}");
      return [];
    }
  }

  static Future<Map<String, dynamic>> get(String path) async {
    GeneralController controller = Get.find();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'charset': 'utf-8',
    };
    if (controller.token.value != "") {
      headers['Authorization'] = 'Bearer ${controller.token.value}';
    }

    final url = Uri.parse('$BASE_URL$path');
    final response = await http.get(url, headers: headers);

    final Map<String, dynamic> data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        "status": !data.containsKey('error'),
        "message": data.containsKey('error') ? data["error"] : "",
        "data": data.containsKey('error') ? null : data,
      };
    } else {
      print("❌ Erreur GET $path: ${response.statusCode}");
      return {
        "status": false,
        "message": data["error"] ?? "Erreur inconnue",
        "data": null,
      };
    }
  }
}
