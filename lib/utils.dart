import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(
    BuildContext context, {
    @required String text,
  }) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
