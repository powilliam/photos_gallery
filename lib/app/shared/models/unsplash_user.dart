import 'package:equatable/equatable.dart';
import 'package:photo_gallery/app/shared/models/unsplash_user_image.dart';

class UnsplashUser extends Equatable {
  UnsplashUser({this.id, this.username, this.name, this.profileImage})
      : assert(id != null),
        assert(username != null),
        assert(name != null),
        assert(profileImage != null);

  final String id;
  final String username;
  final String name;
  final UnsplashUserImage profileImage;

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      "username": username,
      "name": name,
      "profile_image": profileImage.toJSON()
    };
  }

  static UnsplashUser fromJSON(Map<String, dynamic> map) {
    return UnsplashUser(
        id: map['id'],
        username: map["username"],
        name: map["name"],
        profileImage: UnsplashUserImage.fromJSON(map["profile_image"]));
  }

  @override
  List<Object> get props => [id, username, name, profileImage];

  @override
  String toString() =>
      "UnsplashUser{id: $id, username: $username, name: $name, profile_image: ${profileImage.toString()}}";
}
