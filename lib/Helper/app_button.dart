import 'package:flutter/material.dart';

class Appbutton extends StatelessWidget {
  const Appbutton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        textScaleFactor: 1.1,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 45),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffd12534),
        ),
       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
