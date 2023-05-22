import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spellchecker/responce_screen.dart';
import 'algorithms/endcode.dart';
import 'indicator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _controller = TextEditingController();

  //Apiga Post request jo'natish

  Map<String, dynamic> responseMap = {};
  Future<void> getData(List<String> words) async {
    var url = Uri.parse('https://expensim.online/spellCheck/');
    final response =
        await http.post(url, body: jsonEncode({'words': words}), headers: {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Accept": "*/*"
    });
    print(response.statusCode);
    responseMap = jsonDecode(response.body);
    setState(() {});
  }

  Widget pageResp = Container();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //Asosiy UI qismi
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            width: double.maxFinite,
            // height: 380,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                  left: 100.0, right: 100.0, top: 30.0, bottom: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextFormField(
                controller: _controller,
                minLines: 2,
                maxLength: 1000,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(labelText: 'Matn kiriting!'),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: SizedBox()),
              TextButton(
                // Apiga reques junatib

                  onPressed: () async {
                    if (_controller.text != '') {
                      pageResp = IndicatorCircular();
                      setState(() {});
                      var url =
                          Uri.parse('https://expensim.online/spellCheck/');
                      // print(getList(_controller.text));
                      final response = await http.post(url,
                          body:
                              jsonEncode({'words': getList(_controller.text)}),
                          headers: {
                            'Content-Type': 'application/json',
                            "Access-Control-Allow-Origin": "*",
                            "Accept": "*/*"
                          });
                      // print(response.body);
                      responseMap = jsonDecode(response.body);
                      setState(() {
                        pageResp = ResponsePage(responseMap);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)),
                    height: 40.0,
                    width: 90.0,
                    alignment: Alignment.center,
                    child: Text(
                      'Tekshirish',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(child: SizedBox()),
            ],
          ),
          pageResp
        ],
      ),
    );
  }
}
