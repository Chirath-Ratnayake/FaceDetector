import 'package:faceDetector/UI/Auth/Login.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginView(),
    );
  }
}
