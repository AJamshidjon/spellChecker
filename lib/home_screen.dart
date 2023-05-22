// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class PostResponse{
//   static Future<void> getData(List<String> data) async{
//     var url = Uri.parse('https://expensim.online/spellCheck/');
//     print(url);
//     final response = await http.post(url,
//         body: jsonEncode({'words':data}),
//         headers: {'Content-Type': 'application/json',
//           "Access-Control-Allow-Origin": "*",
//           "Accept": "*/*"
//         });
//     print(response.statusCode);
//     print(response.body as Map<String, dynamic>);
//   }
//   Map<String, dynamic> convertData(Future<Map<String, dynamic>> res){
//     return res as Map<String, dynamic>;
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(List<String> words) async {
  var url = Uri.parse('https://expensim.online/spellCheck/');
    final response = await http.post(url,
        body: jsonEncode({'words':words}),
        headers: {'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Accept": "*/*"
        });

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final List<Map<String, dynamic>> data;

  const Album({required this.data});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      data: json['data'],
    );
  }
}


class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() {
    return _MyAppState1();
  }
}

class _MyAppState1 extends State<MyApp1> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum([_controller.text]);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data?.data[0]['word']);
          return Text(snapshot.data?.data[0]['word']);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}