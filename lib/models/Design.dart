import 'package:flutter/material.dart';

class Design {
  final int id;
  final title;
  final author;
  final link;
  final imageAsset;
  final String imageHash;
  final route;
  final Color paletteColor;
  final String sourceCodeUrl;
  bool isFavorite;

  Design(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.author,
      @required this.link,
      @required this.imageAsset,
      @required this.imageHash,
      @required this.paletteColor,
      @required this.route,
      @required this.sourceCodeUrl,
      this.isFavorite = false})
      : assert(id != null),
        assert(title != null),
        assert(author != null),
        assert(imageAsset != null),
        assert(imageHash != null),
        assert(paletteColor != null),
        assert(route != null),
        assert(sourceCodeUrl != null),
        assert(link != null);
}
