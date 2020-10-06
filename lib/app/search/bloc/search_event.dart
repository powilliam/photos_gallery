import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchResetted extends SearchEvent {
  @override
  String toString() => "SearchResetted{}";
}

class SearchSubmitted extends SearchEvent {
  SearchSubmitted({this.query, this.page = 1, this.limit = 10});

  final String query;
  final int page;
  final int limit;

  @override
  String toString() =>
      "SearchSubmitted{query: $query, page: $page, limit: $limit}";
}

class SearchLoaded extends SearchEvent {
  SearchLoaded({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  @override
  String toString() => "SearchLoaded{page: $page, limit: $limit}";
}
