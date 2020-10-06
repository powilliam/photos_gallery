import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/featured/bloc/featured_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_event.dart';
import 'package:photo_gallery/app/featured/bloc/featured_state.dart';
import 'package:photo_gallery/app/featured/repositories/featured_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class MockFeaturedRepository extends Mock
    implements FeaturedRepositoryContract {}

void main() {
  MockFeaturedRepository repository;
  FeaturedBloC bloc;
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
    repository = new MockFeaturedRepository();
    bloc = new FeaturedBloC(repository: repository);

    when(repository.list(any)).thenAnswer((_) async => images);
  });

  blocTest<FeaturedBloC, FeaturedState>(
      'Should be able to emit [FeaturedLoadInProgress, FeaturedSuccess] when event is FeaturedListed',
      build: () => bloc,
      act: (bloc) => bloc.add(FeaturedListed(page: 1, limit: 10)),
      expect: [FeaturedLoadInProgress(), FeaturedSuccess(images)]);

  blocTest<FeaturedBloC, FeaturedState>(
      'Should be able to emit [FeaturedLoadInProgress, FeaturedSuccess, FeaturedSuccess] when event is FeaturedListed',
      build: () => bloc,
      act: (bloc) => bloc
        ..add(FeaturedListed(page: 1, limit: 10))
        ..add(FeaturedListed(page: 2, limit: 10)),
      expect: [
        FeaturedLoadInProgress(),
        FeaturedSuccess(images),
        FeaturedLoadInProgress(images),
        FeaturedSuccess([...images, ...images])
      ]);

  blocTest<FeaturedBloC, FeaturedState>(
      'Should be able to emit [FeaturedLoadInProgress, FeaturedFailure] when event is FeaturedListed and repository throws an exception',
      build: () => bloc,
      act: (bloc) {
        when(repository.list(any)).thenThrow(Exception());
        bloc.add(FeaturedListed(page: 1, limit: 10));
      },
      expect: [FeaturedLoadInProgress(), FeaturedFailure()]);
}
