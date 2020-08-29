import 'package:flutter/foundation.dart';

class UserProfile {
  String name;
  String location;
  String info;
  String profileImage;
  @required
  SocialInfo socialInfo;
  @required
  List<String> galleryPhotos;

  UserProfile(
    this.socialInfo,
    this.galleryPhotos, {
    this.name,
    this.location,
    this.info,
    this.profileImage,
  });
}

class SocialInfo {
  int followers;
  int posts;
  int following;

  SocialInfo({this.followers, this.posts, this.following});
}

String thumbnailWidth = "200";
String profilePictureWidth = "750";

List<UserProfile> getDummyUserProfiles() {

  //TODO: use http://randomuser.me/ instead of dummy data

  return [
    UserProfile(
      SocialInfo(followers: 198, following: 665, posts: 135),
      [
        "https://images.unsplash.com/photo-1485778303651-5df62b8ba895?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1500917293891-ef795e70e1f6?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1507697245577-3aa792ce56d3?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1593575620443-1025938586c6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80"
      ],
      name: "Lori Perez",
      location: "France, Nantes",
      info: "Photoreporter at 'Le Monde', blogger and freelance journalist.",
      profileImage:
          "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
              profilePictureWidth +
              "&q=80",
    ),
    UserProfile(
      SocialInfo(followers: 355, following: 112, posts: 267),
      [
        "https://images.unsplash.com/photo-1586198438643-797e07a5a2ca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1533665979589-79d43a11fdad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1507697245577-3aa792ce56d3?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80"
      ],
      name: "Alma Guerro",
      location: "Spain, Barcelona",
      info: "Travel Blogger and Photographer",
      profileImage:
          "https://images.unsplash.com/photo-1485778303651-5df62b8ba895?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
              profilePictureWidth +
              "&q=80",
    ),
    UserProfile(
      SocialInfo(followers: 256, following: 85, posts: 15),
      [
        "https://images.unsplash.com/photo-1533665979589-79d43a11fdad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1593575620443-1025938586c6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1507697245577-3aa792ce56d3?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
        "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
            thumbnailWidth +
            "&q=80",
      ],
      name: "Zohre Nemati",
      location: "France, Paris",
      info: "Event Manager, Entrepreneur and Gamer.",
      profileImage:
          "https://images.unsplash.com/photo-1535276120455-84c8ada2414b?ixlib=rb-1.2.1&auto=format&fit=crop&w=" +
              profilePictureWidth +
              "&q=80",
    ),
  ];
}
