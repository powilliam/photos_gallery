import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

void main() => runApp(App(
      unsplashService: UnsplashService(
          dio: Dio(BaseOptions(baseUrl: "https://api.unsplash.com", headers: {
        "Authorization": "Client-ID 9XVThSa36lIuwFtQJPeeGsQdPYoj5EraLwH-LCB1Ub0"
      }))),
    ));
