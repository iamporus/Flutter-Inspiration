import 'package:flutter/cupertino.dart';
import 'package:flutter_design_challenge/designs/_5_chapter_mobile_app/ChapterMobileAppDesign.dart';
import 'package:flutter_design_challenge/models/Design.dart';

import '_1_sign_in_sign_up_by_giga/SignUpDesign.dart';
import '_2_game_app_concept_by_zoltan/GameAppConceptDesign.dart';
import '_3_plant_shop/PlantShopHomeDesign.dart';
import '_4_iphone_x_social_app/IPhoneXSocialAppDesign.dart';

class DesignListing {
  static final resolution = "600x445";
  static final designs = [
    Design(
        id: 0,
        title: "iPhone X Social App",
        author: "Shakuro",
        link: "https://dribbble.com/shots/3898209-iPhone-X-Social-App",
        imageAsset:
            "https://cdn.dribbble.com/users/110372/screenshots/3898209/andrew_morozkin_-_user_profile_2.gif",
        imageHash: "LkP?,ZRj~qxuWBj[t7ax-;j[IUay",
        paletteColor: Color(0xFF35322E),
        route: IPhoneXSocialAppDesign(),
        sourceCodeUrl:
            "https://github.com/iamporus/flutter_design_challenges/blob/master/lib/designs/_4_iphone_x_social_app/IPhoneXSocialAppDesign.dart"),
    Design(
      id: 1,
      title: "Sign in / Sign up UI",
      author: "Giga Tamarashvili",
      link: "https://dribbble.com/shots/6371155-Sign-in-Sign-up-UI",
      imageAsset:
          "https://cdn.dribbble.com/users/952958/screenshots/6371155/2_4x.png?compress=1&resize=" +
              resolution,
      imageHash: "*YONUe\$y~B9FWB%M-4NcNx-;xZRj-;n~Iox]WBWAkCR+WCxuW=Rj",
      paletteColor: Color(0xFF53859C),
      route: SignUpDesign(),
      sourceCodeUrl:
          "https://github.com/iamporus/flutter_design_challenges/tree/master/lib/designs/_1_sign_in_sign_up_by_giga",
    ),
    Design(
      id: 2,
      title: "Simple Game App Concept",
      author: "Zoltán Czigány",
      link:
          "https://dribbble.com/shots/13752058-Daliy-UI-Simple-Game-App-Concept",
      imageAsset:
          "https://cdn.dribbble.com/users/4231329/screenshots/13752058/media/c58801393386278c8c36a6f9ab2a9a9b.png?compress=1&resize=" +
              resolution,
      imageHash: "LAFGILJA00~WTz%M-;Io00xu^+9Z",
      paletteColor: Color(0xFF536D80),
      route: GameAppConceptDesign(),
      sourceCodeUrl:
          "https://github.com/iamporus/flutter_design_challenges/blob/master/lib/designs/_2_game_app_concept_by_zoltan/GameAppConceptDesign.dart",
    ),
    Design(
        id: 3,
        title: "Plant Shop",
        author: "Julia Jakubiak",
        link: "https://dribbble.com/shots/6158149-Plant-Shop",
        imageAsset:
            "https://cdn.dribbble.com/users/1558331/screenshots/6158149/6_4x.png?compress=1&resize=" +
                resolution,
        imageHash: "LfM*a7Rknn%3WCRjofxu~Ea{IoNF",
        paletteColor: Color(0xFF359A58),
        route: PlantShopHomeDesign(),
        sourceCodeUrl:
            "https://github.com/iamporus/flutter_design_challenges/blob/master/lib/designs/_3_plant_shop/PlantShopHomeDesign.dart"),
    Design(
        id: 4,
        title: "Mobile App - Chapter",
        author: "Outcrowd",
        link: "https://dribbble.com/shots/11524146-Mobile-app-Chapter",
        imageAsset:
            "https://static.dribbble.com/users/702789/screenshots/11524146/media/e801469b335bd9800168287a0fc48c73.png?compress=1&resize=" +
                resolution,
        imageHash: "L7SrioD+@X~o.8oLVsS2^c%LM|Dk",
        paletteColor: Color(0xFFa3705a),
        route: ChapterMobileAppDesign(),
        sourceCodeUrl:
            "https://github.com/iamporus/flutter_design_challenges/blob/master/lib/designs/_5_chapter_mobile_app/ChapterHomeDesign.dart"),
  ];

  static int getAvailableDesignCount() {
    return designs.length;
  }

  static List<Design> getAvailableDesigns() {
    return designs;
  }
}
