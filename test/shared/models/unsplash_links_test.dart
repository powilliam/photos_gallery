import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/shared/models/unsplash_links.dart';

void main() {
  final Map<String, dynamic> linksMap = {
    "self": "https://localhost:3333",
    "html": "https://localhost:3333",
    "download": "https://localhost:3333",
    "download_location": "https://localhost:3333"
  };

  test('Should be able to define from JSON', () {
    final UnsplashLinks links = UnsplashLinks.fromJSON(linksMap);

    expect(links.self, linksMap["self"]);
    expect(links.html, linksMap["html"]);
    expect(links.download, linksMap["download"]);
    expect(links.downloadLocation, linksMap["download_location"]);
  });

  test('Should be able to return as JSON', () {
    final UnsplashLinks links = UnsplashLinks(
      self: linksMap["self"],
      html: linksMap["html"],
      download: linksMap["download"],
      downloadLocation: linksMap["download_location"],
    );

    expect(links.toJSON(), linksMap);
  });
}
