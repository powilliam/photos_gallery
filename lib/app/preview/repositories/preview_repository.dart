import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/app/shared/services/download_service.dart';

class PreviewRepositoryDownloadDTO {
  PreviewRepositoryDownloadDTO({this.url, this.name})
      : assert(url != null),
        assert(name != null);

  final String url;
  final String name;

  @override
  String toString() => "PreviewRepositoryDownloadDTO{url: $url, name: $name}";
}

abstract class PreviewRepositoryContract {
  Future<File> download(PreviewRepositoryDownloadDTO dto);
}

class PreviewRepository implements PreviewRepositoryContract {
  PreviewRepository({this.downloadService}) : assert(downloadService != null);

  final DownloadServiceContract downloadService;

  @override
  Future<File> download(PreviewRepositoryDownloadDTO dto) async {
    try {
      final List<int> bytes = await downloadService.execute(dto.url);
      final File file = await _create(dto.name);
      await _write(file, bytes);
      return file;
    } catch (e) {
      throw "PreviewRepository{message: ${e.toString()}, dto: ${dto.toString()}}";
    }
  }

  Future<File> _create(String name) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      return new File('${directory.path}/$name.jpeg');
    } catch (e) {
      throw "PreviewRepository{message: ${e.toString()}, name: $name}";
    }
  }

  Future<void> _write(File file, Uint8List bytes) async {
    try {
      await file.writeAsBytes(bytes);
    } catch (e) {
      throw "PreviewRepository{message: ${e.toString()}, file: ${file.toString()}, bytes: ${bytes.toString()}";
    }
  }
}
