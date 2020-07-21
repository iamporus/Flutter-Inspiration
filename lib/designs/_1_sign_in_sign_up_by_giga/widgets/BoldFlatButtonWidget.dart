import 'package:flutter/material.dart';

class BoldFlatButtonWidget extends StatelessWidget {
  final title;
  final color;

  const BoldFlatButtonWidget({
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
        child: Text(
          title,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
