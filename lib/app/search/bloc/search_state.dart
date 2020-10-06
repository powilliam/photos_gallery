import 'package:equatable/equatable.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

abstract class SearchState extends Equatable {
  SearchState({this.query, this.images = const []});

  final String query;
  final List<UnsplashImage> images;

  @override
  List<Object> get props => [query, images];
}

class SearchInitial extends SearchState {
  @override
  String toString() => "SearchInitial{}";
}

class SearchEmpty extends SearchState {
  SearchEmpty({this.query}) : super(query: query, images: []);

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => "SearchEmpty{query: $query}";
}

class SearchLoadInProgress extends SearchState {
  SearchLoadInProgress({this.query, this.images = const []})
      : super(query: query, images: images);

  final String query;
  final List<UnsplashImage> images;

  @override
  List<Object> get props => [query, images];

  @override
  String toString() => "SearchLoadInProgress{query: $query, images: $images}";
}

class SearchSuccess extends SearchState {
  SearchSuccess({this.query, this.images = const []})
      : super(query: query, images: images);

  final String query;
  final List<UnsplashImage> images;

  @override
  List<Object> get props => [query, images];

  @override
  String toString() => "SearchSuccess{query: $query, images: $images}";
}

class SearchFailure extends SearchState {
  @override
  String toString() => "SearchFailure{}";
}
