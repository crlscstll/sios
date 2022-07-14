import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:sios_app/providers/providers.dart';
import 'package:sios_app/services/services.dart';

import '../models/service.dart';

class FeedBackProvider extends ChangeNotifier {
  GlobalKey<FormState> feedbackKey = GlobalKey<FormState>();

  String description = '';
  String feedBack = '';
  String solution = '';

  late File file; // = File(image!.path);
  // XFile? image;

  bool isNetworkEquip = false;
  bool isTerminalEquip = false;

  bool isFile = false;

  List<String> staff = [];
  List<String> device = [];

  changeIsNetworkEquip(bool value) {
    isNetworkEquip = value;
    isNetworkEquip ? device.add('red') : device.remove('red');
    notifyListeners();
  }

  changeisTerminalEquip(bool value) {
    isTerminalEquip = value;
    isTerminalEquip ? device.add('terminal') : device.remove('terminal');
    notifyListeners();
  }

  tap(String value) {
    if (staff.contains(value)) {
      staff.remove(value);
    } else {
      staff.add(value);
    }

    notifyListeners();
  }

  bool checkSelected(String value) {
    if (staff.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  finalize(Service service, BuildContext context) async {
    service.description = description;
    service.solution = solution;
    service.feedback = feedBack;

    service.devices = device;

    context.read<SocketProvider>().finalizeService(
          '621c19019cef936ea47c9645',
          service.assignedTo.id,
          service,
        );

    // print("TRYING TO SEND");

    if (isFile) {
      // print("FILE EXISTS");
      var request = http.MultipartRequest(
          'POST', Uri.parse(imgServiceUploadURL + service.id));

      //  request.fields['name'] = "imagen";
      request.files.add(
        http.MultipartFile.fromBytes(
          'imagen',
          File(file.path).readAsBytesSync(),
          filename: file.path,
        ),
      );

      // print("SENDING");
      var res = await request.send();
      // print("SENT: " + res.statusCode.toString());
    }

  }

  fileExists(bool b) {
    isFile = b;
    notifyListeners();
  }

  printData() {
    print('descripcion: $description');
    print('feedback: $feedBack');
    print('solucion: $solution');
    print('device: $device');
    print('staff: $staff');
  }

  restartValues() {
    description = '';
    feedBack = '';
    solution = '';
    isNetworkEquip = false;
    isTerminalEquip = false;
    staff = [];
    isFile = false;
  }
}
