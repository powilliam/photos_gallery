import 'package:equatable/equatable.dart';

abstract class FeaturedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FeaturedListed extends FeaturedEvent {
  FeaturedListed({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  @override
  List<Object> get props => [page, limit];

  @override
  String toString() => "FeaturedListed{page: $page, limit: $limit}";
}
