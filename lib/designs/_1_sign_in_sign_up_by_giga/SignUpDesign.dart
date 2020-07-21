import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'widgets/FabWidget.dart';
import 'widgets/HeaderWidget.dart';
import 'widgets/TextFormFieldWidget.dart';

class SignUpDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SignUpLayout(),
          ),
        ],
      ),
    );
  }
}

class SignUpLayout extends StatefulWidget {
  @override
  _SignUpLayoutState createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<SignUpLayout> {
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
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPaint(),
        child: buildLayout(),
      ),
      floatingActionButton: FabWidget(topMargin: _keyboardState ? 8 : 64),
      floatingActionButtonLocation: _keyboardState
          ? FloatingActionButtonLocation.endDocked
          : FloatingActionButtonLocation.endFloat,
    );
  }

  Container buildLayout() {
    return Container(
      child: Column(
        children: <Widget>[
          Visibility(
            visible: !_keyboardState,
            child: Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: HeaderWidget(title: 'Create \nAccount', titleSize: 26)),
          ),
          Flexible(fit: FlexFit.loose, flex: 3, child: buildInputFields()),
          Visibility(
              visible: !_keyboardState,
              child: Flexible(
                flex: 1,
                child: SignUpButtonWidget(),
              )),
          Visibility(
              visible: !_keyboardState,
              child: Flexible(
                flex: 1,
                child: SignInButtonWidget(),
              )),
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
            name: 'Name',
            labelColor: Colors.white,
            underlineColor: Color.fromARGB(100, 255, 255, 255),
          ),
          TextFormFieldWidget(
              name: 'Email',
              labelColor: Colors.white,
              underlineColor: Color.fromARGB(100, 255, 255, 255)),
          TextFormFieldWidget(
              name: 'Password',
              labelColor: Colors.white,
              underlineColor: Color.fromARGB(100, 255, 255, 255)),
        ],
      ),
    );
  }
}

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.all(-8),
        child: Text(
          "Sign In",
          style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              color: Colors.white),
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Sign up",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

const MaterialColor darkBlueGray = const MaterialColor(
  0xFF37474f,
  const <int, Color>{
    50: const Color(0xFF37474f),
    100: const Color(0xFF37474f),
    200: const Color(0xFF37474f),
    300: const Color(0xFF37474f),
    400: const Color(0xFF37474f),
    500: const Color(0xFF37474f),
    600: const Color(0xFF37474f),
    700: const Color(0xFF37474f),
    800: const Color(0xFF37474f),
    900: const Color(0xFF37474f),
  },
);

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    //paint blue-gray background
    final path = Path();
    path.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.blueGrey.shade800;
    canvas.drawPath(path, paint);
    path.close();

    //paint the blue path
    Path bluePath = Path();
    paint.color = Colors.lightBlue.shade200;
    bluePath.moveTo(0, height * 0.5);
    bluePath.quadraticBezierTo(
        width * 0.15, height * 0.32, width * 0.5, height * 0.3);
    bluePath.quadraticBezierTo(
        width * 0.85, height * 0.28, width, height * 0.15);
    bluePath.lineTo(width, height);
    bluePath.lineTo(0, height);
    bluePath.close();
    canvas.drawPath(bluePath, paint);
    bluePath.close();

    //paint the white path
    Path whitePath = Path();
    paint.color = Colors.white;
    whitePath.moveTo(width * 0.50, height);
    whitePath.quadraticBezierTo(
        width * 0.55, height * .92, width * 0.78, height * 0.85);
    whitePath.quadraticBezierTo(
        width * 0.88, height * .83, width, height * 0.76);
    whitePath.lineTo(width, height);
    canvas.drawPath(whitePath, paint);
    whitePath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
