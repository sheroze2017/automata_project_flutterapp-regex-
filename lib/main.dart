import 'package:automata_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'screens/home.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "AutomataProject",
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBD6DfuTlqwshYOJ5-hCpUvrOBQa55HlMw',
          appId: '1:283370780667:android:91dc2a480f491b9a683d5e',
          messagingSenderId:
              '283370780667-2eogk642abn5jerroebg1130cti6senu.apps.googleusercontent.com',
          projectId: 'automataproject-1c1e7'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automata Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen(),
    );
  }
}
