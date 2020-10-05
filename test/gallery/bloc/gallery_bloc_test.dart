import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_event.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_state.dart';
import 'package:photo_gallery/app/gallery/repositories/gallery_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';

class MockGalleryRepository extends Mock implements GalleryRepositoryContract {}

void main() {
  MockGalleryRepository repository;
  GalleryBloC galleryBloC;
  List<UnsplashImage> listOfImage = List.generate(
      3,
      (_) => UnsplashImage.fromJSON({
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
          }));

  setUp(() {
    repository = MockGalleryRepository();
    galleryBloC = GalleryBloC(repository: repository);

    when(repository.getImages(page: 1, per_page: 10))
        .thenAnswer((_) async => listOfImage);
    when(repository.searchImages(query: "Code", page: 1, per_page: 10))
        .thenAnswer((_) async => listOfImage);
  });

  tearDown(() {
    reset(repository);
  });

  blocTest<GalleryBloC, GalleryState>(
      'Should be able to emit [GalleryStateLoadInProgress, GalleryStateSuccess] when GalleryGetted',
      build: () => galleryBloC,
      act: (bloc) => bloc.add(GalleryGetted(page: 1, limit: 10)),
      expect: [
        GalleryStateLoadInProgress(),
        GalleryStateSuccess(images: listOfImage, page: 1, isSearching: false)
      ]);

  blocTest<GalleryBloC, GalleryState>(
      'Should be able to emit [GalleryStateLoadInProgress, GalleryStateFailure] when GalleryGetted',
      build: () {
        when(repository.getImages(page: 1, per_page: 10)).thenThrow("Error");
        return galleryBloC;
      },
      act: (bloc) => bloc.add(GalleryGetted(page: 1, limit: 10)),
      expect: [GalleryStateLoadInProgress(), GalleryStateFailure()]);

  blocTest<GalleryBloC, GalleryState>(
      'Should be able to emit [GalleryStateLoadInProgress, GalleryStateSuccess] when GallerySearched',
      build: () => galleryBloC,
      act: (bloc) =>
          bloc.add(GallerySearched(query: "Code", page: 1, limit: 10)),
      expect: [
        GalleryStateLoadInProgress(),
        GalleryStateSuccess(
            images: listOfImage, page: 1, isSearching: true, query: "Code")
      ]);

  blocTest<GalleryBloC, GalleryState>(
      'Should be able to emit [GalleryStateLoadInProgress, GalleryStateFailure] when GallerySearched',
      build: () {
        when(repository.searchImages(query: "Code", page: 1, per_page: 10))
            .thenThrow("Error");
        return galleryBloC;
      },
      act: (bloc) => bloc.add(GallerySearched(query: "Code", page: 1, limit: 10)),
      expect: [GalleryStateLoadInProgress(), GalleryStateFailure()]);
}
