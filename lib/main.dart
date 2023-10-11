import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper/view/bbc.dart';
import 'package:newspaper/view/home_page.dart';
import 'package:newspaper/view/login.dart';
import 'package:newspaper/view/signUp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (FirebaseAuth.instance.currentUser!=null&&FirebaseAuth.instance.currentUser!.emailVerified)?
      const HomePage():const Login(),
      routes: {
        "signup":(context) => const SignUp(),
        "login":(context) => const Login(),
        "homepage": (context) =>  const HomePage(),
      },
    );
  }
}

// https://newsapi.org/v2/top-headlines?country=us&apiKey=90947d7a9b2e438aa5575a74a95a43c2
// 90947d7a9b2e438aa5575a74a95a43c2