import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_challenge/designs/_1_sign_in_sign_up_by_giga/SignUpDesign.dart';
import 'package:flutter_design_challenge/designs/_1_sign_in_sign_up_by_giga/SignInDesign.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Challenges',
      theme: ThemeData(
        primarySwatch: darkBlueGray,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInDesign(),
    );
  }
}
