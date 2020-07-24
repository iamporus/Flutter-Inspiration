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

  static List<Plant> getDummyPlants() {
    return [
      Plant(
          name: "Aloe Vera",
          category: PlantCategory.Top,
          price: 25,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_3.png",
          info:
              "Aloe vera is a succulent plant species of the genus Aloe. It's medicinal uses and air purifying ability make it the plant that you shouldn't live without."),
      Plant(
          name: "Ficus",
          category: PlantCategory.Top,
          price: 30,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_5.png",
          info:
              "If you're completely new to houseplants then Ficus is a brilliant first plant to adopt, it is very easy to look after and won't occupy too much space."),
      Plant(
          name: "Succulent",
          category: PlantCategory.Outdoor,
          price: 27,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_4.png",
          info:
              "When you need houseplants that can thrive with little water, look no further than these succulents to add to your collection."),
      Plant(
          name: "Peace Lily",
          category: PlantCategory.Outdoor,
          price: 22,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_2.png",
          info:
              "A long-time favorite of those with a green-thumb and even those without, Peace Lily is an adaptable and low-maintenance houseplant."),
      Plant(
          name: "ZZ Plant",
          category: PlantCategory.Indoor,
          price: 35,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_1.png",
          info:
              "ZZ plant is the quiet hero of nearly any Instagram-worthy houseplant collection, the stalwart soldier in the corner of the photo frame."),
      Plant(
          name: "Coffee Plant",
          category: PlantCategory.Indoor,
          price: 15,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_4.png",
          info:
              "Coffee grows well indoors in any bright room, but its lush look is ideal for bedrooms, dens, and family rooms where you want to create a cozy look."),
      Plant(
          name: "Rubber Plants",
          category: PlantCategory.Plant_Garden,
          price: 25,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Medium,
          image: "assets/plant_3.png",
          info:
              "Rubber Plant is a popular houseplant because of its waxy leaves and larger-than-life appearance."),
      Plant(
          name: "Pilea",
          category: PlantCategory.Plant_Garden,
          price: 21,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/plant_6.png",
          info:
              "Pilea are known for their bright green, coin-shaped leaves. They grow well in dry conditions, and are fast-growing, making them great for beginner plant owners."),
      Plant(
          name: "Anthurium",
          category: PlantCategory.Office,
          price: 30,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Medium,
          image: "assets/plant_1.png",
          info:
              "The flowers of the Anthurium are some of the longest-lasting on earth, which means that dazzling color will last in your home for months."),
      Plant(
          name: "Snake Plants",
          category: PlantCategory.Office,
          price: 30,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Large,
          image: "assets/plant_2.png",
          info:
              "The snake plant, commonly referred to as mother-in-law's tongue, is a resilient succulent that can grow anywhere between 6 inches to several feet."),
    ];
  }
}

enum PlantSize { Small, Medium, Large }
enum PlantCategory { Top, Indoor, Outdoor, Office, Plant_Garden }
