import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sios_app/env.dart';
import 'package:sios_app/models/models.dart';
import 'package:sios_app/services/services.dart';

class ServiceQuery extends ChangeNotifier{

  final baseUrl  = Env.baseUrl;

  ServiceResponse? serviceResponse;
  
  List<Service> history = [];

  final int _historyPage = 1;

  Future getService (String idService)async{
    final token = await AuthService.getToken();
    // print('token : $token');
    final resp = await http.get(Uri.parse('$baseUrl/api/services/$idService'),headers: {
      'authorization': 'Bearer $token'
    });
    if(resp.statusCode == 200){
      final jsonData = json.decode(resp.body);
      final serviceResponse = ServiceResponse.fromMap(jsonData).service;
      return serviceResponse;
    }

  }

  Future getHistory () async {

    final userId = await AuthService.getUserId();
    // print(userId);

    final resp = await http.get(Uri.parse('$baseUrl/api/services/history/site/$userId?page=$_historyPage'));
    if (resp.statusCode == 200) {
      final jsonData = json.decode(resp.body);
      final history = HistoryResponse.fromMap(jsonData).services;
      return history;
    }

  }
  
}