import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_gallery/app/preview/repositories/preview_repository.dart';

class MockPreviewRepository extends Mock implements PreviewRepositoryContract {}

void main() {
  MockPreviewRepository repository;
  File file;

  setUp(() {
    repository = new MockPreviewRepository();
    file = new File('preview_repository_test.txt');

    when(repository.download(any)).thenAnswer((_) async => file);
  });

  test('Should be able to download', () async {
    expect(
        await repository.download(PreviewRepositoryDownloadDTO(
            name: "name", url: "https://localhost:3333")),
        file);
  });
}
