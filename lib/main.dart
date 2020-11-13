import 'package:flutter/material.dart';
import 'package:flutter_ble_messenger/view/pages/welcome.dart';
import 'package:flutter_ble_messenger/view/widgets/common/custom_scroll_behavior.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.native,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Color(0xFF6c65f8),
        buttonColor: Color(0xFF69f0ae),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black54),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
            behavior: CustomScrollBehavior(), child: child);
      },
      home: Welcome(),
    );
  }
}
