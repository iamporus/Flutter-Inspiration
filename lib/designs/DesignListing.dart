import 'package:flutter_design_challenge/models/Design.dart';

import '_1_sign_in_sign_up_by_giga/SignInDesign.dart';
import '_1_sign_in_sign_up_by_giga/SignUpDesign.dart';

class DesignListing {
  static final designs = [
    Design(
        title: "Sign In UI",
        author: "Giga Tamarashvili",
        link: "https://dribbble.com/shots/6371155-Sign-in-Sign-up-UI",
        imageAsset: "assets/giga_sign_in.png",
        route: SignInDesign()),
    Design(
        title: "Sign up UI",
        author: "Giga Tamarashvili",
        link: "https://dribbble.com/shots/6371155-Sign-in-Sign-up-UI",
        imageAsset: "assets/giga_sign_up.png",
        route: SignUpDesign())
  ];

  static int getAvailableDesignCount() {
    return designs.length;
  }

  static List<Design> getAvailableDesigns() {
    return designs;
  }
}
