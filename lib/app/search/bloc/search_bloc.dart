import 'package:bloc/bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_event.dart';
import 'package:photo_gallery/app/search/bloc/search_state.dart';
import 'package:photo_gallery/app/search/repositories/search_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class SearchBloC extends Bloc<SearchEvent, SearchState> {
  SearchBloC({this.repository})
      : assert(repository != null),
        super(SearchInitial());

  final SearchRepositoryContract repository;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    yield* _mapStateToLoadInProgress();
    if (event is SearchResetted) {
      yield* _mapSearchReseted(event);
    }
    if (event is SearchSubmitted) {
      yield* _mapSearchSubmittedToState(event);
    }
    if (event is SearchLoaded) {
      yield* _mapSearchLoadedToState(event);
    }
  }

  Stream<SearchLoadInProgress> _mapStateToLoadInProgress() async* {
    yield SearchLoadInProgress(query: state.query, images: state.images);
  }

  Stream<SearchFailure> _mapStateToFailure() async* {
    yield SearchFailure();
  }

  Stream<SearchEmpty> _mapStateToEmpty<T extends SearchEvent>(T event) async* {
    yield SearchEmpty(
        query: (event is SearchSubmitted) ? event.query : state.query);
  }

  Stream<SearchInitial> _mapSearchReseted(SearchResetted event) async* {
    yield SearchInitial();
  }

  Stream<SearchState> _mapSearchSubmittedToState(SearchSubmitted event) async* {
    try {
      final List<UnsplashImage> images = await repository.search(
          SearchRepositorySearchDTO(
              query: event.query, page: event.page, limit: event.limit));
      if (images.isEmpty) {
        yield* _mapStateToEmpty<SearchSubmitted>(event);
      } else {
        yield SearchSuccess(images: images, query: event.query);
      }
    } catch (e) {
      yield* _mapStateToFailure();
    }
  }

  Stream<SearchState> _mapSearchLoadedToState(SearchLoaded event) async* {
    try {
      final List<UnsplashImage> images = await repository.search(
          SearchRepositorySearchDTO(
              query: state.query, page: event.page, limit: event.limit));
      yield SearchSuccess(
          images: [...state.images, ...images], query: state.query);
    } catch (e) {
      yield* _mapStateToFailure();
    }
  }
}
