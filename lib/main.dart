import 'package:firebase_core/firebase_core.dart';
import 'package:playbook/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:playbook/login.dart';
import 'package:playbook/home.dart';
import 'package:playbook/diary.dart';
import 'package:playbook/diary_read.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); 
  runApp(MyApp());
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
        "/diary_read" : (context) => DiaryReadPage(diaryId: "diartId",)
      },
    );
  }
}
