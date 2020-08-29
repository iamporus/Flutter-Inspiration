import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'sign_up_design.dart';

class SignInDesign extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
      body: CustomPaint(
        painter: _BackgroundPaint(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenSizeInfo.screenHeight * 0.1),
            child: _SignInAppBar(),
          ),
          body: _SignInLayout(),
        ),
      ),
    );
  }
}

class _SignInLayout extends StatefulWidget {
  @override
  _SignInLayoutState createState() => _SignInLayoutState();
}

class _SignInLayoutState extends State<_SignInLayout> {
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
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: _ArrowFloatingActionButton(
            topMargin: !_keyboardState
                ? screenSizeInfo.screenHeight * 0.10
                : screenSizeInfo.screenHeight * 0.15,
            onPressed: () {
              _navigateToSignUp(context);
            },
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: (!_keyboardState ||
                      screenSizeInfo.deviceScreenType ==
                          DeviceScreenType.Tablet),
                  child: Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingLarge, 0, 0, 0),
                        child: _Header(
                          title: 'Welcome \nBack',
                        ),
                      )),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: _buildInputFields(screenSizeInfo)),
                Visibility(
                    visible: !_keyboardState,
                    child: Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingMedium, 0, 0, 0),
                        child: _BoldFlatButton(
                          title: "Sign in",
                          color: Colors.black,
                          onPressed: () {
                            _navigateToSignUp(context);
                          },
                        ),
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Visibility(
                    visible: true,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingMedium,
                          0, screenSizeInfo.paddingMedium, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _UnderlinedFlatButton(
                            title: "Sign up",
                            color: Colors.black,
                          ),
                          _UnderlinedFlatButton(
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
          ),
        );
      },
    );
  }

  Widget _buildInputFields(ScreenSizeInfo screenSizeInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingMedium, 0, screenSizeInfo.paddingMedium, 0),
      child: Column(
        children: <Widget>[
          _TextFormField(
              name: 'Email',
              labelColor: Colors.grey,
              underlineColor: Colors.grey),
          _TextFormField(
              name: 'Password',
              labelColor: Colors.grey,
              underlineColor: Colors.grey),
        ],
      ),
    );
  }
}

void _navigateToSignUp(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return SignUpDesign();
  }));
}

class _BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    //paint white background
    final path = Path();
    paint.color = Colors.white;
    path.addRect(Rect.fromLTRB(0, 0, width, height));
    canvas.drawPath(path, paint);
    path.close();

    paint.color = Colors.lightBlue.shade200;
    //paint the blue path
    Path bluePath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
          width * 0.35, height * 0.30, width * 0.6, height * 0.4)
      ..quadraticBezierTo(width * 0.90, height * 0.53, width, height * 0.50)
      ..lineTo(width, 0);
    canvas.drawPath(bluePath, paint);
    bluePath.close();

    //paint the black path
    paint.color = Colors.blueGrey.shade800;
    Path blackPath = Path()
      ..moveTo(0, height * 0.39)
      ..quadraticBezierTo(
          width * 0.35, height * 0.53, width * 0.52, height * 0.35)
      ..quadraticBezierTo(
          width * 0.58, height * 0.25, width * 0.75, height * 0.20)
      ..quadraticBezierTo(width * 0.98, height * 0.15, width, height * 0.10)
      ..lineTo(width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(blackPath, paint);
    bluePath.close();

    //paint the amber path
    paint.color = Colors.amber.shade800;
    Path amberPath = Path()
      ..moveTo(0, height * 0.20)
      ..quadraticBezierTo(
          width * 0.10, height * 0.20, width * 0.17, height * 0.17)
      ..quadraticBezierTo(
          width * 0.29, height * 0.09, width * 0.30, height * 0.09)
      ..quadraticBezierTo(
          width * 0.40, height * 0.05, width * 0.48, height * 0.035)
      ..lineTo(width * 0.63, 0)
      ..lineTo(0, 0);

    canvas.drawPath(amberPath, paint);
    bluePath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class _SignInAppBar extends BaseStatelessWidget {
  const _SignInAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSizeInfo.paddingSmall, 0, 0, 0),
      child: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: screenSizeInfo.textSizeMedium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class _Header extends BaseStatelessWidget {
  final String title;

  const _Header({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            fontSize: screenSizeInfo.textSizeXLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}

class _BoldFlatButton extends BaseStatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const _BoldFlatButton(
      {Key key, @required this.title, @required this.color, this.onPressed})
      : assert(title != null),
        assert(color != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: screenSizeInfo.textSizeLarge,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ),
    );
  }
}

class _TextFormField extends BaseStatelessWidget {
  const _TextFormField({
    Key key,
    @required this.name,
    @required this.labelColor,
    @required this.underlineColor,
  })  : assert(name != null),
        assert(labelColor != null),
        assert(underlineColor != null),
        super(key: key);

  final String name;
  final Color labelColor;
  final Color underlineColor;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingMedium,
          screenSizeInfo.paddingSmall,
          screenSizeInfo.paddingSmall,
          screenSizeInfo.paddingSmall),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: screenSizeInfo.textSizeMedium,
            color: Colors.pink.shade300),
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: name,
            contentPadding: EdgeInsets.all(8),
            labelStyle: TextStyle(color: labelColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: underlineColor)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: underlineColor))),
      ),
    );
  }
}

class _ArrowFloatingActionButton extends BaseStatelessWidget {
  final double topMargin;
  final VoidCallback onPressed;

  const _ArrowFloatingActionButton(
      {Key key, @required this.topMargin, this.onPressed})
      : assert(topMargin != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      height: screenSizeInfo.screenWidth * 0.18,
      width: screenSizeInfo.screenWidth * 0.18,
      margin: EdgeInsets.fromLTRB(
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        topMargin,
      ),
      child: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: screenSizeInfo.textSizeMedium,
            ),
            onPressed: onPressed),
      ),
    );
  }
}

class _UnderlinedFlatButton extends BaseStatelessWidget {
  final String title;
  final Color color;

  const _UnderlinedFlatButton({
    Key key,
    @required this.title,
    @required this.color,
  })  : assert(title != null),
        assert(color != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
              fontSize: screenSizeInfo.textSizeMedium,
              decoration: TextDecoration.underline,
              color: color),
        ),
      ),
    );
  }
}
