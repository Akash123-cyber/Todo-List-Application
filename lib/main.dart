import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ToDo/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // here initializing the hive
  await Hive.initFlutter();

  //opening a box for database
  var box = await Hive.openBox("mybox");

  //load .env file
  await dotenv.load(fileName: "secrets.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
      home: HomePage(),
     
    );
  }
}
