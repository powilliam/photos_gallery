import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/search/repositories/search_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class MockUnsplashService extends Mock implements UnsplashServiceContract {}

void main() {
  MockUnsplashService unsplashService;
  SearchRepository searchRepository;
  Map<String, dynamic> data = {
    "results": [
      {
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
      }
    ]
  };

  setUp(() {
    unsplashService = new MockUnsplashService();
    searchRepository = new SearchRepository(unsplashService: unsplashService);

    when(unsplashService.search(any)).thenAnswer((_) async => data);
  });

  tearDown(() {
    reset(unsplashService);
  });

  test('Should be able to list searched images', () async {
    expect(
        await searchRepository.search(SearchRepositorySearchDTO(query: "Code")),
        [UnsplashImage.fromJSON(data["results"][0])]);
  });
}
