import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sios_app/models/models.dart';
import 'package:sios_app/env.dart';

class LogService extends ChangeNotifier{

  late LogResponse logResponse;
  final baseUrl = Env.baseUrl;

  Future getLog() async{
    final jsonData = await http.get(Uri.parse('$baseUrl/api/services/bitacora?page=1'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }


  
  Future getLogSearch(String query) async{
    final jsonData = await http.get(Uri.parse('$baseUrl/api/search/$query'));
    return logResponse = LogResponse.fromJson(jsonData.body);
  }
  
}