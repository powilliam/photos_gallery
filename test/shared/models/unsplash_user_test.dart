import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user_image.dart';

void main() {
  Map<String, dynamic> userMap = {
    "id": "123",
    "username": "username",
    "name": "name",
    "profile_image": {
      "small": "https://localhost:3333",
      "medium": "https://localhost:3333",
      "large": "https://localhost:3333",
    }
  };

  test('Should be able to define from JSON', () {
    final UnsplashUser user = UnsplashUser.fromJSON(userMap);

    expect(user.id, userMap["id"]);
    expect(user.username, userMap["username"]);
    expect(user.name, userMap["name"]);
    expect(user.profileImage.small, userMap["profile_image"]["small"]);
    expect(user.profileImage.medium, userMap["profile_image"]["medium"]);
    expect(user.profileImage.large, userMap["profile_image"]["large"]);
  });

  test('Should be able to return as JSON', () {
    final UnsplashUser user = UnsplashUser(
        id: userMap["id"],
        username: userMap["username"],
        name: userMap["name"],
        profileImage: UnsplashUserImage(
          small: userMap["profile_image"]["small"],
          medium: userMap["profile_image"]["medium"],
          large: userMap["profile_image"]["large"],
        ));

    expect(user.toJSON(), userMap);
  });
}
