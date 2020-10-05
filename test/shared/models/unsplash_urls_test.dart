import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/shared/models/unsplash_urls.dart';

void main() {
  Map<String, dynamic> urlsMap = {
    "raw": "https://localhost:3333",
    "full": "https://localhost:3333",
    "regular": "https://localhost:3333",
    "small": "https://localhost:3333",
    "thumb": "https://localhost:3333",
  };

  test('Should be able to define from JSON', () {
    final UnsplashUrls urls = UnsplashUrls.fromJSON(urlsMap);

    expect(urls.raw, urlsMap["raw"]);
    expect(urls.full, urlsMap["full"]);
    expect(urls.regular, urlsMap["regular"]);
    expect(urls.small, urlsMap["small"]);
    expect(urls.thumb, urlsMap["thumb"]);
  });

  test('Should be able to return as JSON', () {
    final UnsplashUrls urls = UnsplashUrls(
      raw: urlsMap["raw"],
      full: urlsMap["full"],
      regular: urlsMap["regular"],
      small: urlsMap["small"],
      thumb: urlsMap["thumb"],
    );

    expect(urls.toJSON(), urlsMap);
  });
}
