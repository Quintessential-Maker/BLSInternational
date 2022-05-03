import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        const SizedBox(width: 10),
        Text(text),
        const SizedBox(width: 10),
        const Expanded(child: Divider()),
      ],
    );
  }
}
