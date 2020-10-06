import 'package:equatable/equatable.dart';
import 'package:photo_gallery/app/shared/models/unsplash_links.dart';
import 'package:photo_gallery/app/shared/models/unsplash_urls.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user.dart';

class UnsplashImage extends Equatable {
  UnsplashImage({this.id, this.urls, this.links, this.user})
      : assert(id != null),
        assert(urls != null),
        assert(links != null),
        assert(user != null);

  final String id;
  final UnsplashUrls urls;
  final UnsplashLinks links;
  final UnsplashUser user;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'urls': urls.toJSON(),
      'links': links.toJSON(),
      'user': user.toJSON()
    };
  }

  static UnsplashImage fromJSON(Map<String, dynamic> map) {
    return UnsplashImage(
        id: map['id'],
        urls: UnsplashUrls.fromJSON(map['urls']),
        links: UnsplashLinks.fromJSON(map['links']),
        user: UnsplashUser.fromJSON(map["user"]));
  }

  @override
  List<Object> get props => [id, urls, links];

  @override
  String toString() =>
      "UnsplashImage{id: $id, urls: ${urls.toString()}, links: ${links.toString()}, user: ${user.toString()}}";
}
