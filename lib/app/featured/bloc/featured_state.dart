import 'package:equatable/equatable.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

abstract class FeaturedState extends Equatable {
  FeaturedState([this.images = const []]);

  final List<UnsplashImage> images;

  @override
  List<Object> get props => [images];

  @override
  String toString() => "FeaturedState{images: ${images.toString()}";
}

class FeaturedLoadInProgress extends FeaturedState {
  FeaturedLoadInProgress([this.images = const []]) : super(images);

  final List<UnsplashImage> images;

  @override
  List<Object> get props => [images];

  @override
  String toString() => "FeaturedLoadInProgress{images: ${images.toString()}";
}

class FeaturedInitial extends FeaturedState {
  @override
  String toString() => "FeaturedInitial{}";
}

class FeaturedSuccess extends FeaturedState {
  FeaturedSuccess([this.images = const []]) : super(images);

  final List<UnsplashImage> images;

  @override
  List<Object> get props => [images];

  @override
  String toString() => "FeaturedSuccess{images: ${images.toString()}";
}

class FeaturedFailure extends FeaturedState {
  FeaturedFailure([this.images = const []]) : super(images);

  final List<UnsplashImage> images;

  @override
  List<Object> get props => [images];

  @override
  String toString() => "FeaturedFailure{images: ${images.toString()}";
}
