import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/app/landing_page.dart';
import 'package:flutter_udemy_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
        title: 'Учет времени',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
