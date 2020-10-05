import 'package:equatable/equatable.dart';

class UnsplashLinks extends Equatable {
  UnsplashLinks({this.self, this.html, this.download, this.downloadLocation})
      : assert(self != null),
        assert(html != null),
        assert(download != null),
        assert(downloadLocation != null);

  final String self;
  final String html;
  final String download;
  final String downloadLocation;

  Map<String, dynamic> toJSON() {
    return {
      'self': self,
      "html": html,
      "download": download,
      "download_location": downloadLocation,
    };
  }

  static UnsplashLinks fromJSON(Map<String, dynamic> map) {
    return UnsplashLinks(
      self: map['self'],
      html: map["html"],
      download: map["download"],
      downloadLocation: map["download_location"],
    );
  }

  @override
  List<Object> get props => [self, html, download, downloadLocation];
}
