import 'package:flutter/material.dart';

class Nav {
  static to(BuildContext context, Widget page) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  static off(BuildContext context, Widget page) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  static back(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
