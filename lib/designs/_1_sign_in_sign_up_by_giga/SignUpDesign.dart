import 'package:flutter/material.dart';

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

class SignUpLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPaint(),
        child: Container(
          child: Column(
            children: <Widget>[
              buildHeader(),
              buildInputFields(),
              buildSignUpButton(),
              buildSignIn(),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Container buildFab() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 64),
      child: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: null),
      ),
    );
  }

  Flexible buildSignIn() {
    return Flexible(
      flex: 1,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(-8),
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Flexible buildSignUpButton() {
    return Flexible(
      flex: 1,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            "Sign up",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Flexible buildInputFields() {
    return Flexible(
      flex: 3,
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            buildTextField("Name"),
            buildTextField("Email"),
            buildTextField('Password'),
          ],
        ),
      ),
    );
  }

  Flexible buildHeader() {
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
          child: Text(
            "Create \nAccount",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Container buildTextField(String name) {
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
