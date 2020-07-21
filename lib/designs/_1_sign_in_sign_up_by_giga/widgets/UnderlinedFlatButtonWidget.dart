import 'package:flutter/material.dart';

class UnderlinedFlatButtonWidget extends StatelessWidget {
  final title;
  final color;

  const UnderlinedFlatButtonWidget({
    Key key,
    @required this.title,
    @required this.color,
  })  : assert(title != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.all(-8),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16, decoration: TextDecoration.underline, color: color),
        ),
      ),
    );
  }
}
