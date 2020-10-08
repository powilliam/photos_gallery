import 'dart:async';

import 'package:dio/dio.dart';

abstract class DownloadServiceContract {
  Future<List<int>> execute(String url);
}

class DownloadService implements DownloadServiceContract {
  DownloadService({this.dio}) : assert(dio != null);

  final Dio dio;

  @override
  Future<List<int>> execute(String url) async {
    try {
      final Response<List<int>> response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw "DownloadService{message: ${e.toString()}, url: $url}";
    }
  }
}
