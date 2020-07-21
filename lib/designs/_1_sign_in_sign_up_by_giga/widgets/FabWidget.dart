import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  final double topMargin;

  const FabWidget({
    Key key,
    @required this.topMargin,
  })  : assert(topMargin != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.fromLTRB(16, 16, 16, topMargin),
      child: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
    );
  }
}