import 'package:flutter/material.dart';

class FloatingUpArrowWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingUpArrowWidget({Key key, @required this.onPressed})
      : assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.black.withAlpha(100),
        child: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.red,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
