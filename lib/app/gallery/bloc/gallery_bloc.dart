import 'package:bloc/bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_event.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_state.dart';
import 'package:photo_gallery/app/gallery/repositories/gallery_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class GalleryBloC extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloC({this.repository})
      : assert(repository != null),
        super(GalleryStateInitial());

  final GalleryRepositoryContract repository;

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    yield* _mapStateToLoadInProgress();
    if (event is GalleryGetted) {
      yield* _mapGettedToState(event);
    }
    if (event is GallerySearched) {
      yield* _mapSearchedToState(event);
    }
  }

  Stream<GalleryStateLoadInProgress> _mapStateToLoadInProgress() async* {
    yield GalleryStateLoadInProgress(
        images: state.images,
        page: state.page,
        isSearching: state.isSearching,
        query: state.query);
  }

  Stream<GalleryStateFailure> _mapStateToFailure() async* {
    yield GalleryStateFailure(
        images: state.images,
        page: state.page,
        isSearching: state.isSearching,
        query: state.query);
  }

  Stream<GalleryState> _mapGettedToState(GalleryGetted event) async* {
    try {
      final List<UnsplashImage> images =
          await repository.getImages(page: event.page, per_page: event.limit);
      yield GalleryStateSuccess(
          images: [...state.images, ...images],
          page: event.page,
          isSearching: false);
    } catch (e) {
      yield* _mapStateToFailure();
    }
  }

  Stream<GalleryState> _mapSearchedToState(GallerySearched event) async* {
    try {
      final List<UnsplashImage> images = await repository.searchImages(
          query: event.query, page: event.page, per_page: event.limit);
      yield GalleryStateSuccess(
          images: state.isSearching == true && state.query == event.query
              ? [...state.images, ...images]
              : images,
          page: event.page,
          isSearching: true,
          query: event.query);
    } catch (e) {
      yield* _mapStateToFailure();
    }
  }
}
