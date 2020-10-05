import 'dart:async';

import 'package:photo_gallery/app/gallery/services/unsplash_service.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

abstract class GalleryRepositoryContract {
  Future<List<UnsplashImage>> getImages(
      {int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10});
  Future<List<UnsplashImage>> searchImages(
      {String query,
      int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10});
}

class GalleryRepository implements GalleryRepositoryContract {
  GalleryRepository({this.provider}) : assert(provider != null);

  final UnsplashServiceContract provider;

  Future<List<UnsplashImage>> getImages(
      {int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10}) async {
    try {
      final List<dynamic> imagesMap =
          await provider.getImages(page: page, per_page: per_page);
      return List.generate(
          imagesMap.length, (i) => UnsplashImage.fromJSON(imagesMap[i]));
    } catch (e) {
      throw "GalleryRepository{message: ${e.toString()}}";
    }
  }

  Future<List<UnsplashImage>> searchImages(
      {String query,
      int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10}) async {
    try {
      final response = await provider.searchImages(
          query: query, page: page, per_page: per_page);
      return List.generate(response["results"].length as int,
          (i) => UnsplashImage.fromJSON(response["results"][i]));
    } catch (e) {
      throw "GalleryRepository{message: ${e.toString()}}";
    }
  }
}
