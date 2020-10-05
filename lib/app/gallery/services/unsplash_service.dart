import 'package:dio/dio.dart';

abstract class UnsplashServiceContract {
  Future<List<dynamic>> getImages(
      {int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10});
  Future<dynamic> searchImages(
      {String query,
      int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10});
}

class UnsplashService implements UnsplashServiceContract {
  UnsplashService({this.dio}) : assert(dio != null);

  final Dio dio;

  @override
  Future<List<dynamic>> getImages(
      {int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10}) async {
    try {
      final Response<List<dynamic>> response = await dio.get('/photos',
          queryParameters: {"page": page, "per_page": per_page});
      return response.data;
    } catch (e) {
      throw "UnsplashService{message: ${e.toString()}}";
    }
  }

  @override
  Future<dynamic> searchImages(
      {String query,
      int page = 1,
      // ignore: non_constant_identifier_names
      int per_page = 10}) async {
    try {
      final Response response = await dio.get('/search/photos',
          queryParameters: {
            "query": query,
            "page": page,
            "per_page": per_page
          });
      return response.data;
    } catch (e) {
      throw "UnsplashService{message: ${e.toString()}}";
    }
  }
}
