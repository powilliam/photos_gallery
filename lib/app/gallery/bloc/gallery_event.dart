import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GalleryGetted extends GalleryEvent {
  GalleryGetted({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  @override
  List<Object> get props => [page, limit];

  @override
  String toString() => "GalleryGetted{page: $page, limit: $limit}";
}

class GallerySearched extends GalleryEvent {
  GallerySearched({this.query, this.page = 1, this.limit = 10});

  final String query;
  final int page;
  final int limit;

  @override
  List<Object> get props => [query, page, limit];

  @override
  String toString() =>
      "GallerySearched{query: $query, page: $page, limit: $limit}";
}
