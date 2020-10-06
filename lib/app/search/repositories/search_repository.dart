import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class SearchRepositorySearchDTO {
  SearchRepositorySearchDTO({this.query, this.page = 1, this.limit = 10})
      : assert(query != null);

  final String query;
  final int page;
  final int limit;

  @override
  String toString() =>
      "SearchRepositorySearchDTO{query: $query, page: $page, limit: $limit}";
}

abstract class SearchRepositoryContract {
  Future<List<UnsplashImage>> search(SearchRepositorySearchDTO dto);
}

class SearchRepository implements SearchRepositoryContract {
  SearchRepository({this.unsplashService}) : assert(unsplashService != null);

  final UnsplashServiceContract unsplashService;

  @override
  Future<List<UnsplashImage>> search(SearchRepositorySearchDTO dto) async {
    try {
      final Map<String, dynamic> data = await unsplashService.search(
          UnsplashServiceSearchDTO(
              query: dto.query, page: dto.page, limit: dto.limit));
      return List.generate((data['results'] as List).length,
          (index) => UnsplashImage.fromJSON(data['results'][index]));
    } catch (e) {
      throw "SearchRepository{message: ${e.toString()}, dto: ${dto.toString()}}";
    }
  }
}
