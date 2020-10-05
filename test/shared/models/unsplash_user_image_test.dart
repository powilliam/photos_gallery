import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user_image.dart';

void main() {
  Map<String, dynamic> imageMap = {
    "small": "https://localhost:3333",
    "medium": "https://localhost:3333",
    "large": "https://localhost:3333",
  };

  test('Should be able to define from JSON', () {
    final UnsplashUserImage image = UnsplashUserImage.fromJSON(imageMap);

    expect(image.small, imageMap["small"]);
    expect(image.medium, imageMap["medium"]);
    expect(image.large, imageMap["large"]);
  });

  test('Should be able to return as JSON', () {
    final UnsplashUserImage image = UnsplashUserImage(
      small: imageMap["small"],
      medium: imageMap["medium"],
      large: imageMap["large"],
    );

    expect(image.toJSON(), imageMap);
  });
}
