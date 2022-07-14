import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sios_app/env.dart';
import 'package:sios_app/models/models.dart';

class UsersSiteProvider extends ChangeNotifier{

 SiteUsers usuariosSite = SiteUsers(status: false, users:[]);
 final baseUrl = Env.baseUrl;

  Future getSiteUsers() async {

    final resp = await http.get(Uri.parse('$baseUrl/api/users/all/active'));
    if (resp.statusCode == 200) {
      usuariosSite = siteUsersFromJson(resp.body);

      return usuariosSite.users;
    }
    
  }
  
}