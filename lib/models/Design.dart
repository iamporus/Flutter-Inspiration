import 'package:flutter/material.dart';

class Design {
  final title;
  final author;
  final link;
  final imageAsset;
  final String imageHash;
  final route;
  Color paletteColor;

  Design(
      {Key key,
      @required this.title,
      @required this.author,
      @required this.link,
      @required this.imageAsset,
      @required this.imageHash,
      @required this.route,
      this.paletteColor})
      : assert(title != null),
        assert(author != null),
        assert(imageAsset != null),
        assert(imageHash != null),
        assert(route != null),
        assert(link != null);
}
