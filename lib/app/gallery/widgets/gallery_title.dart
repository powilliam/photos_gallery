import 'package:flutter/material.dart';

class GalleryTitle extends StatelessWidget {
  GalleryTitle({Key key, @required this.title})
      : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Text(
      title,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
