import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:historycontacts/di/Locator.dart';
import 'package:historycontacts/view/widget/HomeWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contactos estrechos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeWidget(),
    );
  }
}
