import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sios_app/models/models.dart';
import 'package:sios_app/env.dart';

class AuthService extends ChangeNotifier{

  final baseUrl = Env.baseUrl;
  late User user;
  final storage = const FlutterSecureStorage();

  //* Funcion que hace la peticion de Login

  Future<bool> login( String ncontrol, String password ) async {

    final authData = {
      'username': ncontrol,
      'password': password
    };

    final resp = await http.post( Uri.parse('$baseUrl/api/auth/login'),
      body: jsonEncode(authData),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    final Map<String,dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('user')) {
      await storage.write(key: 'userId', value: decodedResp['user']['_id']);
    }

    if(decodedResp.containsKey('accessToken')){
      await storage.write(key: 'token', value: decodedResp['accessToken']);
      user = User.convertirJson(decodedResp['user']);
      print(user.id);
      return true;
    }else{
      return false;
    }

  }

  //* Funcion que cierra sesion 

  Future logout () async {

    await storage.delete(key: 'token');
    await storage.delete(key: 'userId');
    return; 
    
  }

  //* Verifica si el token es valido

  Future<bool> verifyToken () async{

    final token = await storage.read(key: 'token') ?? 'olakease';
    
    final resp = await http.get(Uri.parse('$baseUrl/api/auth/renew'),headers: {
      'authorization': 'Bearer $token'
    });

    final Map<String,dynamic> decodedResp = json.decode(resp.body);

    if(decodedResp['status'] == true){
      user = User.convertirJson(decodedResp['user']);
    }
    return decodedResp['status'];

  }

  //* Metodo para enviar token

  static Future<String> getToken() async {
    
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;

  }

  static Future<String> getUserId() async{
    const _storage = FlutterSecureStorage();
    final userId = await _storage.read(key: 'userId');
    return userId!;
  }

}