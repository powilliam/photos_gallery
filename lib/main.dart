import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/app/gallery/repositories/gallery_repository.dart';
import 'package:photo_gallery/app/gallery/services/unsplash_service.dart';

void main() => runApp(App(
      repository: GalleryRepository(
          provider: UnsplashService(
              dio: Dio(BaseOptions(
                  baseUrl: "https://api.unsplash.com",
                  headers: {"Authorization": "Client-ID --"})))),
    ));
