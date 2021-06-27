import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});

  @override
  State<StatefulWidget> createState() => StatefulWrapperState();
}

class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () => {widget.onInit()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
