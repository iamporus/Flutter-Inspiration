import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_1_sign_in_sign_up_by_giga/SignInDesign.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'widgets/BoldFlatButtonWidget.dart';
import 'widgets/FabWidget.dart';
import 'widgets/HeaderWidget.dart';
import 'widgets/SigningAppBarWidget.dart';
import 'widgets/TextFormFieldWidget.dart';
import 'widgets/UnderlinedFlatButtonWidget.dart';

class SignUpDesign extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
      body: CustomPaint(
        painter: _BackgroundPaint(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenSizeInfo.screenHeight * 0.1),
            child: SigningAppBarWidget(),
          ),
          body: SignUpLayout(),
        ),
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
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FabWidget(
          topMargin: !_keyboardState
              ? screenSizeInfo.screenHeight * 0.10
              : screenSizeInfo.screenHeight * 0.05,
          onPressed: () {
            _navigateToSignIn(context);
          },
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: (!_keyboardState ||
                    screenSizeInfo.deviceScreenType == DeviceScreenType.Tablet),
                child: Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingLarge, 0, 0, 0),
                        child: HeaderWidget(title: 'Create \nAccount'))),
              ),
              Flexible(fit: FlexFit.loose, flex: 3, child: _buildInputFields()),
              Visibility(
                  visible: !_keyboardState,
                  child: Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingMedium, 0, 0, 0),
                        child: BoldFlatButtonWidget(
                          title: "Sign Up",
                          color: Colors.white,
                          onPressed: () {
                            _navigateToSignIn(context);
                          },
                        ),
                      ))),
              Visibility(
                  visible: !_keyboardState,
                  child: Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          screenSizeInfo.paddingMedium, 0, 0, 0),
                      child: UnderlinedFlatButtonWidget(
                        title: "Sign In",
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }

  Padding _buildInputFields() {
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

void _navigateToSignIn(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SignInDesign();
  }));
}

class _BackgroundPaint extends CustomPainter {
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
