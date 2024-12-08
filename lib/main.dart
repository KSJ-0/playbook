import 'package:flutter/material.dart';
import 'package:playbook/login.dart';
import 'package:playbook/home.dart';
import 'package:playbook/diary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playbook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/",
      routes: {
        "/" : (context) => const Login(),
        "/home" : (context) => const HomePage(title: "home"),
        "/diary" : (context) => const DiaryPage(title: "diary",),
      },
    );
  }
}
