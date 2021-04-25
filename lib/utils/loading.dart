import 'package:flutter/material.dart';

loading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text("Loading")),
        content: LinearProgressIndicator(),
      ));
}
