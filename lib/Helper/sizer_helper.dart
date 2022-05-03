import 'package:flutter/material.dart';

class Sizer {
  static double dHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double dWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static vSpace(BuildContext context, dynamic height) {
    return SizedBox(height: dHeight(context) * height);
  }

  static hSpace(BuildContext context, dynamic width) {
    return SizedBox(width: dWidth(context) * width);
  }
}
