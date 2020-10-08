import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class MockDio extends Mock implements Dio {}

class MockUnsplashService extends Mock implements UnsplashServiceContract {}

void main() {
  MockDio dio;
  UnsplashService unsplashService;
  List<Map<String, dynamic>> data = List.generate(
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

  setUp(() async {
    dio = new MockDio();
    unsplashService = new UnsplashService(dio: dio);
  });

  tearDown(() {
    reset(dio);
  });

  test('Should be able to get images', () async {
    when(dio.get('/photos', queryParameters: {"page": 1, "per_page": 10}))
        .thenAnswer((_) async => new Response(data: data));
    expect(await unsplashService.list(UnsplashServiceListDTO()), data);
  });

  test('Should be able to search images', () async {
    when(dio.get('/search/photos',
            queryParameters: {"query": "Code", "page": 1, "per_page": 10}))
        .thenAnswer((_) async => new Response(data: {"results": data}));
    expect(
        await unsplashService.search(UnsplashServiceSearchDTO(query: "Code")),
        {"results": data});
  });
}
