import 'package:flutter/material.dart';

class IndicatorCircular extends StatefulWidget {
  const IndicatorCircular({Key? key}) : super(key: key);

  @override
  State<IndicatorCircular> createState() => _IndicatorCircularState();
}

class _IndicatorCircularState extends State<IndicatorCircular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 50.0,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
