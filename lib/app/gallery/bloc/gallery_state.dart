import 'package:equatable/equatable.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

abstract class GalleryState extends Equatable {
  GalleryState(
      {this.images = const [], this.page, this.isSearching, this.query});

  final List<UnsplashImage> images;
  final int page;
  final bool isSearching;
  final String query;

  @override
  List<Object> get props => [images, page, isSearching, query, query];
}

class GalleryStateInitial extends GalleryState {
  @override
  String toString() => "GalleryStateInitial{}";
}

class GalleryStateLoadInProgress extends GalleryState {
  GalleryStateLoadInProgress(
      {this.images = const [], this.page, this.isSearching, this.query})
      : super(
            images: images, page: page, isSearching: isSearching, query: query);

  final List<UnsplashImage> images;
  final int page;
  final bool isSearching;
  final String query;

  @override
  List<Object> get props => [images, page, isSearching, query];

  @override
  String toString() =>
      "GalleryStateLoadInProgress{images: $images, page: $page, isSearching: $isSearching, query: $query}";
}

class GalleryStateSuccess extends GalleryState {
  GalleryStateSuccess(
      {this.images = const [], this.page, this.isSearching, this.query})
      : super(
            images: images, page: page, isSearching: isSearching, query: query);

  final List<UnsplashImage> images;
  final int page;
  final bool isSearching;
  final String query;

  @override
  List<Object> get props => [images, page, isSearching, query];

  @override
  String toString() =>
      "GalleryStateSuccess{images: $images, page: $page, isSearching: $isSearching, query: $query}";
}

class GalleryStateFailure extends GalleryState {
  GalleryStateFailure(
      {this.images = const [], this.page, this.isSearching, this.query})
      : super(
            images: images, page: page, isSearching: isSearching, query: query);

  final List<UnsplashImage> images;
  final int page;
  final bool isSearching;
  final String query;

  @override
  List<Object> get props => [images, page, isSearching, query];

  @override
  String toString() =>
      "GalleryStateFailure{images: $images, page: $page, isSearching: $isSearching, query: $query}";
}
