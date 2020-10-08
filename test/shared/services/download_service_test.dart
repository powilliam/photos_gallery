import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/shared/services/download_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio dio;
  DownloadService downloadService;

  setUp(() {
    dio = new MockDio();
    downloadService = new DownloadService(dio: dio);

    when(dio.get(any))
        .thenAnswer((_) async => new Response<List<int>>(data: [1, 2, 3]));
  });

  tearDown(() {
    reset(dio);
  });

  test('Should be able to return a list of ints as bytes', () async {
    expect(await downloadService.execute("http://localhost:3333"), [1, 2, 3]);
  });
}
