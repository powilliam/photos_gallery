import 'package:equatable/equatable.dart';

class UnsplashUrls extends Equatable {
  UnsplashUrls({this.raw, this.full, this.regular, this.small, this.thumb})
      : assert(raw != null),
        assert(full != null),
        assert(regular != null),
        assert(small != null),
        assert(thumb != null);

  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  Map<String, dynamic> toJSON() {
    return {
      'raw': raw,
      "full": full,
      "regular": regular,
      "small": small,
      "thumb": thumb
    };
  }

  static UnsplashUrls fromJSON(Map<String, dynamic> map) {
    return UnsplashUrls(
      raw: map['raw'],
      full: map["full"],
      regular: map["regular"],
      small: map["small"],
      thumb: map["thumb"],
    );
  }

  @override
  List<Object> get props => [raw, full, regular, small, thumb];
}
