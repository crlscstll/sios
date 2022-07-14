import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sios_app/env.dart';
import 'package:sios_app/models/models.dart';

class LogSearchProvider extends ChangeNotifier {

  final baseUrl = Env.baseUrl;
  String query = '';
  SearchLogResponse bitacora = SearchLogResponse(status: false, bitacora: []);

  Future getBitacora() async {
    final resp = await http.get(Uri.parse('$baseUrl/api/search/$query'));
    if (resp.statusCode == 200) {
      bitacora = SearchLogResponse.fromJson(resp.body);
      return bitacora;
    }
    notifyListeners();
  }

  setQuery(String q) {
    query = q;
    notifyListeners();
  }

  printData() {}
}
