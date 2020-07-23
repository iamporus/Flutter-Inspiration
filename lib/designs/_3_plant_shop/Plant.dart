
import 'package:flutter/material.dart';

class Plant {
  final name;
  final PlantSize size;
  final PlantCategory category;
  final double price;
  final heightInCm;
  final potWidthInCm;
  final image;
  final info;

  const Plant(
      {Key key,
        @required this.name,
        @required this.category,
        @required this.price,
        @required this.size,
        @required this.image,
        @required this.info,
        @required this.heightInCm,
        @required this.potWidthInCm})
      : assert(name != null),
        assert(category != null),
        assert(price != null),
        assert(size != null),
        assert(image != null),
        assert(info != null),
        assert(heightInCm != null),
        assert(potWidthInCm != null);
}
enum PlantSize { Small, Medium, Large }
enum PlantCategory { Indoor, Outdoor }

