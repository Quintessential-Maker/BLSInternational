import 'package:app_in/wiget/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final String? heading;
  final bool isRequired;
  final T? value;
  final String Function(T)? getLabel;
  final void Function(T?)? onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
    this.heading,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HelperWidget.normalHeading(heading),
            isRequired
                ? Text(
                    " *",
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
          ],
        ),
        FormField<T>(
          builder: (FormFieldState<T> state) {
            return InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
              ),
              isEmpty: value == null || value == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: value,
                  isDense: true,
                  onChanged: onChanged,
                  items: options.map((T value) {
                    return DropdownMenuItem<T>(
                      value: value,
                      child: Text(getLabel!(value)),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
