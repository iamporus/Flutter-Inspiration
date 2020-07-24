import 'package:flutter_design_challenge/models/Design.dart';

import '_1_sign_in_sign_up_by_giga/SignInDesign.dart';
import '_1_sign_in_sign_up_by_giga/SignUpDesign.dart';
import '_2_game_app_concept_by_zoltan/GameAppConceptDesign.dart';
import '_3_plant_shop/PlantShopHomeDesign.dart';

class DesignListing {
  static final resolution = "600x445";
  static final designs = [
    Design(
        title: "Sign in / Sign up UI",
        author: "Giga Tamarashvili",
        link: "https://dribbble.com/shots/6371155-Sign-in-Sign-up-UI",
        imageAsset:
            "https://cdn.dribbble.com/users/952958/screenshots/6371155/2_4x.png?compress=1&resize=" +
                resolution,
        route: SignUpDesign()),
    Design(
        title: "Simple Game App Concept",
        author: "Zoltán Czigány",
        link:
            "https://dribbble.com/shots/13752058-Daliy-UI-Simple-Game-App-Concept",
        imageAsset:
            "https://cdn.dribbble.com/users/4231329/screenshots/13752058/media/c58801393386278c8c36a6f9ab2a9a9b.png?compress=1&resize=" +
                resolution,
        route: GameAppConceptDesign()),
    Design(
        title: "Plant Shop",
        author: "Julia Jakubiak",
        link: "https://dribbble.com/shots/6158149-Plant-Shop",
        imageAsset:
            "https://cdn.dribbble.com/users/1558331/screenshots/6158149/6_4x.png?compress=1&resize=" +
                resolution,
        route: PlantShopHomeDesign())
  ];

  static int getAvailableDesignCount() {
    return designs.length;
  }

  static List<Design> getAvailableDesigns() {
    return designs;
  }
}
