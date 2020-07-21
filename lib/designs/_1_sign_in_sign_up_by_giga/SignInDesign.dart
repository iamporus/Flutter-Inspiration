import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'widgets/BoldFlatButtonWidget.dart';
import 'widgets/FabWidget.dart';
import 'widgets/HeaderWidget.dart';
import 'widgets/TextFormFieldWidget.dart';
import 'widgets/UnderlinedFlatButtonWidget.dart';

class SignInDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabWidget(
        topMargin: MediaQuery.of(context).size.height * 0.15,
      ),
      body: CustomPaint(
        painter: BackgroundPaint(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SignInLayout(),
        ),
      ),
    );
  }
}

class SignInLayout extends StatefulWidget {
  @override
  _SignInLayoutState createState() => _SignInLayoutState();
}

class _SignInLayoutState extends State<SignInLayout> {
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;

  @override
  void initState() {
    _keyboardState = _keyboardVisibility.isKeyboardVisible;
    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return buildLayout();
  }

  Container buildLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Visibility(
            visible: !_keyboardState,
            child: Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: HeaderWidget(title: 'Welcome \nBack', titleSize: 32)),
          ),
          Flexible(fit: FlexFit.loose, flex: 2, child: buildInputFields()),
          Visibility(
              visible: !_keyboardState,
              child: Flexible(
                flex: 1,
                child: BoldFlatButtonWidget(
                  title: "Sign in",
                  color: Colors.black,
                ),
              )),
          Flexible(
            flex: 1,
            child: Visibility(
              visible: true,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    UnderlinedFlatButtonWidget(
                      title: "Sign up",
                      color: Colors.black,
                    ),
                    UnderlinedFlatButtonWidget(
                      title: "Forgot Password",
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildInputFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormFieldWidget(
              name: 'Email',
              labelColor: Colors.grey,
              underlineColor: Colors.grey),
          TextFormFieldWidget(
              name: 'Password',
              labelColor: Colors.grey,
              underlineColor: Colors.grey),
        ],
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    //paint white background
    final path = Path();
    path.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(path, paint);
    path.close();

    //paint the blue path
    Path bluePath = Path();
    paint.color = Colors.lightBlue.shade200;
    bluePath.moveTo(0, 0);
    bluePath.quadraticBezierTo(
        width * 0.35, height * 0.30, width * 0.6, height * 0.4);
    bluePath.quadraticBezierTo(
        width * 0.90, height * 0.53, width, height * 0.50);
    bluePath.lineTo(width, 0);
    canvas.drawPath(bluePath, paint);
    bluePath.close();

    //paint the black path
    Path blackPath = Path();
    paint.color = Colors.blueGrey.shade800;
    blackPath.moveTo(0, height * 0.39);
    blackPath.quadraticBezierTo(
        width * 0.35, height * 0.53, width * 0.52, height * 0.35);
    blackPath.quadraticBezierTo(
        width * 0.58, height * 0.25, width * 0.75, height * 0.20);
    blackPath.quadraticBezierTo(
        width * 0.98, height * 0.15, width, height * 0.10);
    blackPath.lineTo(width, 0);
    blackPath.lineTo(0, 0);

    canvas.drawPath(blackPath, paint);
    bluePath.close();

    //paint the amber path
    Path amberPath = Path();
    paint.color = Colors.amber.shade800;
    amberPath.moveTo(0, height * 0.20);
    amberPath.quadraticBezierTo(
        width * 0.10, height * 0.20, width * 0.17, height * 0.17);
    amberPath.quadraticBezierTo(
        width * 0.29, height * 0.09, width * 0.30, height * 0.09);
    amberPath.quadraticBezierTo(
        width * 0.40, height * 0.05, width * 0.48, height * 0.035);
    amberPath.lineTo(width * 0.63, 0);
    amberPath.lineTo(0, 0);

    canvas.drawPath(amberPath, paint);
    bluePath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
