import 'package:flutter_design_challenge/models/Design.dart';

import '_1_sign_in_sign_up_by_giga/SignInDesign.dart';
import '_1_sign_in_sign_up_by_giga/SignUpDesign.dart';
import '_2_game_app_concept_by_zoltan/GameAppConceptDesign.dart';
import '_3_plant_shop/PlantShopDesign.dart';

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
        route: SignUpDesign()),
    Design(
        title: "Simple Game App Concept",
        author: "Zoltán Czigány",
        link:
            "https://dribbble.com/shots/13752058-Daliy-UI-Simple-Game-App-Concept",
        imageAsset: "assets/game_app_concept_zlotan.png",
        route: GameAppConceptDesign()),
    Design(
        title: "Plant Shop",
        author: "Julia Jakubiak",
        link: "https://dribbble.com/shots/6158149-Plant-Shop",
        imageAsset: "assets/plant_shop_by_julia_jakubiak.png",
        route: PlantShopDesign())
  ];

  static int getAvailableDesignCount() {
    return designs.length;
  }

  static List<Design> getAvailableDesigns() {
    return designs;
  }
}
