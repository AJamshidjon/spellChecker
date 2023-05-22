import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class ResponsePage extends StatefulWidget {
  late Map<String, dynamic> response;
  ResponsePage(Map<String, dynamic> res, {super.key}) {
    response = res;
  }
  @override
  State<ResponsePage> createState() =>
      _ResponsePageState(response['message']['data']);
}

class _ResponsePageState extends State<ResponsePage> {
  late List response;
  _ResponsePageState(List res) {
    response = res;
    print(res);

    for (int i = 0; i < res.length; i++) {
      // print(response[i]);
      response[i]['word'] = response[i]['word'].substring(4);
      // print(response[i]['word']);
    }
  }
  List<TextSpan> listSpan = [];

  int currentIndex = 0;

  void refreshSpan() {
    listSpan = [];
    for (int i = 0; i < response.length; i++) {
      if (response[i]['status'] == 'correct') {
        listSpan.add(TextSpan(
            text: response[i]['word'] as String,
            style: TextStyle(color: Colors.black)));
        listSpan.add(const TextSpan(text: ' '));
      } else {
        listSpan.add(TextSpan(
          text: response[i]['word'] as String,
          style: TextStyle(color: Colors.red),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              currentIndex = i;
              refreshCorrect(response[i]['suggestion']);
              setState(() {});
            },
        ));
        listSpan.add(TextSpan(text: ' '));
      }
    }
  }

  List<TextSpan> listCorrect = [];
  void refreshCorrect(List lst) {
    listCorrect = [];
    for (int i = 0; i < lst.length; i++) {
      listCorrect.add(TextSpan(
          text: lst[i],
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              corrector(lst[i]);
            },
          style: TextStyle(color: Colors.black)));
      listCorrect.add(TextSpan(text: '\n'));
    }
    setState(() {});
  }

  void corrector(String word) {
    response[currentIndex]['word'] = word;
    response[currentIndex]['status'] = 'correct';
    // listSpan[currentIndex] = TextSpan(text: word);
    setState(() {
      refreshSpan();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshSpan();
    refreshCorrect([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.white,
      width: double.maxFinite,
      child: Container(
        margin:
            EdgeInsets.only(left: 100.0, right: 100.0, top: 30.0, bottom: 50.0),
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 3.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  height: double.maxFinite,
                  child: ListView(
                    children: [
                      RichText(
                        text: TextSpan(children: listSpan),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      listSpan = [];
                      listCorrect = [];
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () async {
                        String copyData = '';
                        for (int i = 0; i < response.length; i++) {
                          copyData += response[i]['word'] + ' ';
                        }
                        await Clipboard.setData(ClipboardData(text: copyData));
                      },
                      child: Row(
                        children: [Icon(Icons.copy)],
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.black26,
              // height: double.maxFinite,
              width: 2.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                height: double.maxFinite,
                child: ListView(
                  children: [
                    RichText(
                      text: TextSpan(children: listCorrect),
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
