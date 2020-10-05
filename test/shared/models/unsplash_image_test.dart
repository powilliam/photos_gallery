import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/models/unsplash_links.dart';
import 'package:photo_gallery/app/shared/models/unsplash_urls.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user_image.dart';

void main() {
  Map<String, dynamic> imageMap = {
    'id': '123',
    'urls': {
      "raw": "https://localhost:3333",
      "full": "https://localhost:3333",
      "regular": "https://localhost:3333",
      "small": "https://localhost:3333",
      "thumb": "https://localhost:3333",
    },
    "links": {
      "self": "https://localhost:3333",
      "html": "https://localhost:3333",
      "download": "https://localhost:3333",
      "download_location": "https://localhost:3333"
    },
    "user": {
      "id": "1234",
      "username": "username",
      "name": "name",
      "profile_image": {
        "small": "https://localhost:3333",
        "medium": "https://localhost:3333",
        "large": "https://localhost:3333",
      }
    }
  };

  test('Should be able to define from JSON', () {
    final UnsplashImage image = UnsplashImage.fromJSON(imageMap);

    expect(image.id, imageMap['id']);
    expect(image.urls.raw, imageMap['urls']["raw"]);
    expect(image.urls.full, imageMap['urls']["full"]);
    expect(image.urls.regular, imageMap['urls']["regular"]);
    expect(image.urls.small, imageMap['urls']["small"]);
    expect(image.urls.thumb, imageMap['urls']["thumb"]);
    expect(image.links.self, imageMap['links']["self"]);
    expect(image.links.html, imageMap['links']["html"]);
    expect(image.links.download, imageMap['links']["download"]);
    expect(
        image.links.downloadLocation, imageMap['links']["download_location"]);
    expect(image.user.id, imageMap['user']["id"]);
    expect(image.user.username, imageMap['user']["username"]);
    expect(image.user.name, imageMap['user']["name"]);
    expect(image.user.profileImage.small,
        imageMap['user']["profile_image"]["small"]);
    expect(image.user.profileImage.medium,
        imageMap['user']["profile_image"]["medium"]);
    expect(image.user.profileImage.large,
        imageMap['user']["profile_image"]["large"]);
  });

  test('Should be able return as JSON', () {
    final UnsplashImage image = UnsplashImage(
        id: imageMap["id"],
        links: UnsplashLinks(
          self: imageMap['links']["self"],
          download: imageMap['links']["download"],
          html: imageMap['links']["html"],
          downloadLocation: imageMap['links']["download_location"],
        ),
        urls: UnsplashUrls(
            raw: imageMap['urls']["raw"],
            full: imageMap['urls']["full"],
            regular: imageMap['urls']["regular"],
            thumb: imageMap['urls']["thumb"],
            small: imageMap['urls']["small"]),
        user: UnsplashUser(
          id: imageMap['user']["id"],
          name: imageMap['user']["name"],
          username: imageMap['user']["username"],
          profileImage: UnsplashUserImage(
            small: imageMap["user"]["profile_image"]["small"],
            medium: imageMap["user"]["profile_image"]["medium"],
            large: imageMap["user"]["profile_image"]["large"],
          ),
        ));

    expect(image.toJSON(), imageMap);
  });
}
