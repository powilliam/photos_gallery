import 'package:equatable/equatable.dart';

class UnsplashUserImage extends Equatable {
  UnsplashUserImage({this.small, this.medium, this.large})
      : assert(small != null),
        assert(medium != null),
        assert(large != null);

  final String small;
  final String medium;
  final String large;

  Map<String, dynamic> toJSON() {
    return {'small': small, "medium": medium, "large": large};
  }

  static UnsplashUserImage fromJSON(Map<String, dynamic> map) {
    return UnsplashUserImage(
      small: map['small'],
      medium: map["medium"],
      large: map["large"],
    );
  }

  @override
  List<Object> get props => [small, medium, large];
}
