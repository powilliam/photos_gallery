import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class MockUnsplashService extends Mock implements UnsplashServiceContract {}

void main() {
  MockUnsplashService unsplashService;
  List<Map<String, dynamic>> listOfImageMap = List.generate(
      3,
      (i) => ({
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
    unsplashService = MockUnsplashService();

    when(unsplashService.list(any)).thenAnswer((_) async => listOfImageMap);
    when(unsplashService.search(any))
        .thenAnswer((_) async => {"results": listOfImageMap});
  });

  tearDown(() {
    reset(unsplashService);
  });

  test('Should be able to get images', () async {
    expect(
        await unsplashService.list(UnsplashServiceListDTO()), listOfImageMap);
  });

  test('Should be able to search images', () async {
    expect(
        await unsplashService.search(UnsplashServiceSearchDTO(query: "Code")),
        {"results": listOfImageMap});
  });
}
