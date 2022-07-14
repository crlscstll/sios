import 'package:flutter/material.dart';
import 'package:sios_app/theme/app_theme.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apptheme.primarydark,
        title: const Text('Pantalla de Tareas'),
      ),
      body: const SafeArea(
        child: Center(
        ),
      ),
    );
  }
}
