import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('workerHome'.tr()),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'workerHomeScreen'.tr(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
