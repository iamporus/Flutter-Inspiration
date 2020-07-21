import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key key,
    @required this.name,
    @required this.labelColor,
    @required this.underlineColor,
  })  : assert(name != null),
        assert(labelColor != null),
        assert(underlineColor != null),
        super(key: key);

  final String name;
  final Color labelColor;
  final Color underlineColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 16, color: Colors.pink.shade300),
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: name,
            contentPadding: EdgeInsets.all(8),
            labelStyle: TextStyle(color: labelColor),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: underlineColor)),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: underlineColor))),
      ),
    );
  }
}
