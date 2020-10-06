import 'package:bloc/bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_event.dart';
import 'package:photo_gallery/app/featured/bloc/featured_state.dart';
import 'package:photo_gallery/app/featured/repositories/featured_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class FeaturedBloC extends Bloc<FeaturedEvent, FeaturedState> {
  FeaturedBloC({this.repository})
      : assert(repository != null),
        super(FeaturedInitial());

  final FeaturedRepositoryContract repository;

  @override
  Stream<FeaturedState> mapEventToState(FeaturedEvent event) async* {
    yield* _mapStateToLoadingInProgress();
    if (event is FeaturedListed) {
      yield* _mapListedToState(event);
    }
  }

  Stream<FeaturedLoadInProgress> _mapStateToLoadingInProgress() async* {
    yield FeaturedLoadInProgress(state.images);
  }

  Stream<FeaturedState> _mapListedToState(FeaturedListed event) async* {
    try {
      final List<UnsplashImage> images = await repository.list(
          FeaturedRepositoryListDTO(page: event.page, limit: event.limit));
      yield FeaturedSuccess([...state.images, ...images]);
    } catch (e) {
      yield FeaturedFailure(state.images);
    }
  }
}
