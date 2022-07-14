import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

mostrarAlerta( BuildContext context, String title, String subtitle ) {


  if( Platform.isAndroid ){
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text( title ),
        content: Text( subtitle ),
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
            child: const Text( 'Ok' ),
          )
        ]
      )
    );
  } 

  showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog(
      title: Text( title ),
      content: Text( subtitle ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () => Navigator.pop( context ),
        )
      ],
    )
  );
  

}