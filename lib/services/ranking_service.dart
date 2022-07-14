import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sios_app/env.dart';
import 'package:sios_app/models/models.dart';

class RankingService extends ChangeNotifier {

  final baseUrl = Env.baseUrl;
  
  Future<Period> getRanking() async {
    final jsonData = await http.get(
      Uri.parse('$baseUrl/api/periods/active'),
    );
    return Period.fromJson(jsonData.body);
  }
}
