import 'package:flutter/material.dart';

class GamePriceWidget extends StatelessWidget {
  final priceInDollars;

  const GamePriceWidget({Key key, @required this.priceInDollars})
      : assert(priceInDollars != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(
        "\$" + priceInDollars.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }
}