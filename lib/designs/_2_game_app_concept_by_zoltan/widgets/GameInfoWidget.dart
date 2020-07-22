import 'package:flutter/material.dart';

class GameInfoWidget extends StatelessWidget {
  final infoText;

  const GameInfoWidget({Key key, @required this.infoText})
      : assert(infoText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(
        infoText,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: MediaQuery.of(context).textScaleFactor * 17,
            wordSpacing: 2,
            height: 1.5),
      ),
    );
  }
}
