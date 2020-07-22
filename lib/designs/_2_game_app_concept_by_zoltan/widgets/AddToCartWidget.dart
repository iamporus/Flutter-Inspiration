import 'package:flutter/material.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
          onPressed: () {},
          color: Colors.redAccent.shade700,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Add to Cart",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )),
    );
  }
}
