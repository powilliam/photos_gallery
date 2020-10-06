import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_event.dart';
import 'package:photo_gallery/app/search/bloc/search_state.dart';
import 'package:photo_gallery/app/search/repositories/search_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class MockSearchRepository extends Mock implements SearchRepositoryContract {}

void main() {
  MockSearchRepository repository;
  SearchBloC bloc;
  List<UnsplashImage> images = [
    UnsplashImage.fromJSON({
      'id': '123',
      'urls': {
        "raw": "https://localhost:3333",
        "full": "https://localhost:3333",
        "regular": "https://localhost:3333",
        "small": "https://localhost:3333",
        "thumb": "https://localhost:3333",
      },
      "links": {
        "self": "https://localhost:3333",
        "html": "https://localhost:3333",
        "download": "https://localhost:3333",
        "download_location": "https://localhost:3333"
      },
      "user": {
        "id": "1234",
        "username": "username",
        "name": "name",
        "profile_image": {
          "small": "https://localhost:3333",
          "medium": "https://localhost:3333",
          "large": "https://localhost:3333",
        }
      }
    })
  ];

  setUp(() {
    repository = new MockSearchRepository();
    bloc = new SearchBloC(repository: repository);

    when(repository.search(any)).thenAnswer((_) async => images);
  });

  tearDown(() {
    reset(repository);
  });

  blocTest<SearchBloC, SearchState>(
      'Should be able to emit [SearchLoadInProgress, SearchSuccess] when event is SearchSubmitted',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchSubmitted(
            query: "Code",
          )),
      expect: [
        SearchLoadInProgress(),
        SearchSuccess(query: "Code", images: images)
      ]);

  blocTest<SearchBloC, SearchState>(
      'Should be able to emit [SearchLoadInProgress, SearchSuccess, SearchLoadInProgress, SearchSuccess] when event is SearchSubmitted',
      build: () => bloc,
      act: (bloc) => bloc
        ..add(SearchSubmitted(
          query: "Code",
        ))
        ..add(SearchLoaded(page: 2)),
      expect: [
        SearchLoadInProgress(),
        SearchSuccess(query: "Code", images: images),
        SearchLoadInProgress(query: "Code", images: images),
        SearchSuccess(query: "Code", images: [...images, ...images])
      ]);

  blocTest<SearchBloC, SearchState>(
      'Should be able to emit [SearchLoadInProgress, SearchSuccess, SearchLoadInProgress, SearchInitial] when event is SearchResetted',
      build: () => bloc,
      act: (bloc) => bloc
        ..add(SearchSubmitted(
          query: "Code",
        ))
        ..add(SearchResetted()),
      expect: [
        SearchLoadInProgress(),
        SearchSuccess(query: "Code", images: images),
        SearchLoadInProgress(query: "Code", images: images),
        SearchInitial()
      ]);

  blocTest<SearchBloC, SearchState>(
      'Should be able to emit [SearchLoadInProgress, SearchEmpty] when event is SearchSubmitted and repository returns empty',
      build: () => bloc,
      act: (bloc) {
        when(repository.search(any)).thenAnswer((_) async => []);
        bloc.add(SearchSubmitted(
          query: "Code",
        ));
      },
      expect: [SearchLoadInProgress(), SearchEmpty(query: "Code")]);

  blocTest<SearchBloC, SearchState>(
      'Should be able to emit [SearchLoadInProgress, SearchFailure] when event is SearchSubmitted and repository throws an exception',
      build: () => bloc,
      act: (bloc) {
        when(repository.search(any)).thenThrow(Exception('404 Unauthorized'));
        bloc.add(SearchSubmitted(
          query: "Code",
        ));
      },
      expect: [SearchLoadInProgress(), SearchFailure()]);
}
