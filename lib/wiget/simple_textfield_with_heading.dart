import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper_widget.dart';

class TextFieldWithHeading extends StatefulWidget {
  TextFieldWithHeading(
      {this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.isPassword,
      required this.heading,
      this.keyboardType,
      this.isRequired = false,
      this.textController,
      // required this.errorText
      });

  final String titleText;
  final bool isRequired;
  final TextAlign titleTextAlign;
  final bool? isPassword;
  final String heading;
  // final String errorText;
  final TextInputType? keyboardType;
  final TextEditingController? textController;

  @override
  _TextFieldWithHeadingState createState() => _TextFieldWithHeadingState();
}

class _TextFieldWithHeadingState extends State<TextFieldWithHeading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HelperWidget.normalHeading(widget.heading),
            widget.isRequired
                ? Text(
                    " *",
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
          ],
        ),
        TextField(
          keyboardType: widget.keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            contentPadding:EdgeInsets.zero,
            // errorText: widget.errorText,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
