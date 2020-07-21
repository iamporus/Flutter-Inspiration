import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final title;
  final double titleSize;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.titleSize,
  })  : assert(title != null),
        assert(titleSize != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}
