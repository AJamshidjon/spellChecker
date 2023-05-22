import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

class CheckNetwork extends StatefulWidget {
  const CheckNetwork({Key? key}) : super(key: key);

  @override
  State<CheckNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


networkChecker() async{
  bool result = await InternetConnectionChecker().hasConnection;
  if(result != true) {

  }
}
showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  ()=>exit(0),
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}