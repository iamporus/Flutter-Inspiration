import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';

class DesignWidget extends StatelessWidget {
  final Design design;

  const DesignWidget({Key key, @required this.design});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return design.route;
        }));
      },
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
            child: Card(
              color: Colors.blueGrey.shade500,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          image: AssetImage(design.imageAsset),
                        ),
                      ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      design.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(
                      "by " + design.author,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
