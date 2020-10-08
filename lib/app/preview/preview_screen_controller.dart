import 'dart:async';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/app/preview/repositories/preview_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

abstract class PreviewScreenControllerContract {
  GlobalKey<ScaffoldState> get scaffoldKey;
  Future<File> download(UnsplashImage image);
}

class PreviewScreenController implements PreviewScreenControllerContract {
  PreviewScreenController({this.repository}) : assert(repository != null);

  final PreviewRepositoryContract repository;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Future<File> download(UnsplashImage image) async {
    try {
      return await repository.download(
          PreviewRepositoryDownloadDTO(url: image.urls.full, name: image.id));
    } catch (e) {
      throw "PreviewScreenController{message: ${e.toString()}, image: ${image.toString()}}";
    }
  }
}
