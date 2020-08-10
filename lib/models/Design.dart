import 'package:flutter/material.dart';

class Design {
  final title;
  final author;
  final link;
  final imageAsset;
  final String imageHash;
  final route;
  final Color paletteColor;
  bool isFavorite = false;

  Design(
      {Key key,
      @required this.title,
      @required this.author,
      @required this.link,
      @required this.imageAsset,
      @required this.imageHash,
      @required this.paletteColor,
      @required this.route,
      this.isFavorite})
      : assert(title != null),
        assert(author != null),
        assert(imageAsset != null),
        assert(imageHash != null),
        assert(paletteColor != null),
        assert(route != null),
        assert(link != null);
}
