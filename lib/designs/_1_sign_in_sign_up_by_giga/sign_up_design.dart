import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_1_sign_in_sign_up_by_giga/sign_in_design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

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
            child: _SignUpAppBar(),
          ),
          body: _SignUpLayout(),
        ),
      ),
    );
  }
}

class _SignUpLayout extends StatefulWidget {
  @override
  _SignUpLayoutState createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<_SignUpLayout> {
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
        floatingActionButton: _ArrowFloatingActionButton(
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
                        child: _Header(title: 'Create \nAccount'))),
              ),
              Flexible(fit: FlexFit.loose, flex: 3, child: _buildInputFields()),
              Visibility(
                  visible: !_keyboardState,
                  child: Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingMedium, 0, 0, 0),
                        child: _BoldFlatButton(
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
                      child: _UnderlinedFlatButton(
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
          _TextFormField(
            name: 'Name',
            labelColor: Colors.white,
            underlineColor: Color.fromARGB(100, 255, 255, 255),
          ),
          _TextFormField(
              name: 'Email',
              labelColor: Colors.white,
              underlineColor: Color.fromARGB(100, 255, 255, 255)),
          _TextFormField(
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
    paint.color = Colors.lightBlue.shade200;
    Path bluePath = Path()
      ..moveTo(0, height * 0.5)
      ..quadraticBezierTo(
          width * 0.15, height * 0.32, width * 0.5, height * 0.3)
      ..quadraticBezierTo(width * 0.85, height * 0.28, width, height * 0.15)
      ..lineTo(width, height)
      ..lineTo(0, height);
    canvas.drawPath(bluePath, paint);
    bluePath.close();

    //paint the white path
    paint.color = Colors.white;
    Path whitePath = Path()
      ..moveTo(width * 0.50, height)
      ..quadraticBezierTo(
          width * 0.55, height * .92, width * 0.78, height * 0.85)
      ..quadraticBezierTo(width * 0.88, height * .83, width, height * 0.76)
      ..lineTo(width, height);
    canvas.drawPath(whitePath, paint);
    whitePath.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class _SignUpAppBar extends BaseStatelessWidget {
  const _SignUpAppBar({
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
