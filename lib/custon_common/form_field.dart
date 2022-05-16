import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFieldCustom extends StatelessWidget {
  final String label;
  final bool withAsterisk;

  const FormFieldCustom(
      {Key? key, required this.label, required this.withAsterisk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      /*Container(
        // padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: TextFormField(
          *//*decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),*//*
        ),
      ),*/
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 0, top: 0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: ' $label',
                        style: TextStyle(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            color: Colors.black,
                            fontSize: 14)),
                    TextSpan(
                        text: withAsterisk ? '* ' : ' ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            color: Colors.red)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
