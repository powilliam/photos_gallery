import 'dart:async';

import 'package:dio/dio.dart';

class UnsplashServiceListDTO {
  UnsplashServiceListDTO({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  String toString() => "UnsplashServiceListDTO{page: $page, limit: $limit}";
}

class UnsplashServiceSearchDTO {
  UnsplashServiceSearchDTO({this.query, this.page = 1, this.limit = 10})
      : assert(query != null);

  final String query;
  final int page;
  final int limit;

  String toString() =>
      "UnsplashServiceSearchDTO{query: $query, page: $page, limit: $limit}";
}

abstract class UnsplashServiceContract {
  Future<List<Map<String, dynamic>>> list(UnsplashServiceListDTO dto);
  Future<Map<String, dynamic>> search(UnsplashServiceSearchDTO dto);
}

class UnsplashService implements UnsplashServiceContract {
  UnsplashService({this.dio}) : assert(dio != null);

  final Dio dio;

  @override
  Future<List<Map<String, dynamic>>> list(UnsplashServiceListDTO dto) async {
    try {
      final Response response = await dio.get('/photos',
          queryParameters: {"page": dto.page, "per_page": dto.limit});
      return response.data;
    } catch (e) {
      throw "UnsplashService{message: ${e.toString()}, dto: ${dto.toString()}}";
    }
  }

  @override
  Future<Map<String, dynamic>> search(UnsplashServiceSearchDTO dto) async {
    try {
      final Response response = await dio.get('/search/photos',
          queryParameters: {
            "query": dto.query,
            "page": dto.page,
            "per_page": dto.limit
          });
      return response.data;
    } catch (e) {
      throw "UnsplashService{message: ${e.toString()}, dto: ${dto.toString()}}";
    }
  }
}
