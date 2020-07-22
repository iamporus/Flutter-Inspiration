import 'package:flutter/material.dart';

class GameTitleWidget extends StatelessWidget {
  final gameTitle;

  const GameTitleWidget({Key key, @required this.gameTitle})
      : assert(gameTitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          gameTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
