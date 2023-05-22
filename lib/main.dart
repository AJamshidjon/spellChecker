import 'package:spellchecker/request_screen.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';
void main() async{

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Imlo tekshiruvi'),
          centerTitle: true,
        ),
        body: const RequestPage(),
        ),
    );
  }
}


