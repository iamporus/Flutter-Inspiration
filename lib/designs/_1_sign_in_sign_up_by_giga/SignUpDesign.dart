import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

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
    super.initState();

    _keyboardState = _keyboardVisibility.isKeyboardVisible;
    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: show different layout on keyboard pop up.
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPaint(),
        child: _keyboardState
            ? buildLayoutWhenKeyboardHidden()
            : buildLayoutWhenKeyboardHidden(),
      ),
      floatingActionButton: FabWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Container buildLayoutWhenKeyboardHidden() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: HeaderWidget(title: 'Create \nAccount', titleSize: 26)),
          Flexible(fit: FlexFit.loose, flex: 3, child: buildInputFields()),
          Flexible(flex: 1, child: SignUpButtonWidget()),
          Flexible(flex: 1, child: SignInButtonWidget()),
        ],
      ),
    );
  }

  Container buildLayoutWhenKeyboardShown() {
    return Container(
      child: buildInputFields(),
    );
  }

  Padding buildInputFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormFieldWidget(name: 'Name'),
          TextFormFieldWidget(name: 'Email'),
          TextFormFieldWidget(name: 'Password'),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final title;
  final double titleSize;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.titleSize,
  })  : assert(title != null),
        assert(titleSize != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 64),
      child: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: (){}),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key key,
    @required this.name,
  })  : assert(name != null),
        super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 16, color: Colors.pink.shade300),
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: name,
            contentPadding: EdgeInsets.all(8),
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(100, 255, 255, 255))),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(100, 255, 255, 255)))),
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
