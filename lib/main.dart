import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:accurate_task/core/shared_pref/shard_prefrences_helper.dart';
import 'package:accurate_task/core/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.initializeIntList();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routes.splash,
        onGenerateRoute: RouteManager.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getThemeManager()
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
