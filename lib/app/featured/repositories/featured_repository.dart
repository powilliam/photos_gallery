import 'dart:async';

import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class FeaturedRepositoryListDTO {
  FeaturedRepositoryListDTO({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  @override
  String toString() => "FeaturedRepositoryListDTO{page: $page, limit: $limit}";
}

abstract class FeaturedRepositoryContract {
  Future<List<UnsplashImage>> list(FeaturedRepositoryListDTO dto);
}

class FeaturedRepository implements FeaturedRepositoryContract {
  FeaturedRepository({this.unsplashService}) : assert(unsplashService != null);

  final UnsplashServiceContract unsplashService;

  @override
  Future<List<UnsplashImage>> list(FeaturedRepositoryListDTO dto) async {
    try {
      final List<Map<String, dynamic>> data = await unsplashService
          .list(UnsplashServiceListDTO(page: dto.page, limit: dto.limit));
      return List.generate(
          data.length, (index) => UnsplashImage.fromJSON(data[index]));
    } catch (e) {
      throw "FeaturedRepository{message: ${e.toString()}, dto: ${dto.toString()}}";
    }
  }
}
