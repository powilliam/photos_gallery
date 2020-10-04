import 'package:flutter/material.dart';
import 'package:photo_gallery/app/gallery/gallery_screen.dart';

class App extends StatelessWidget {
  static const String _title = "Photos Gallery";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      home: GalleryScreen(),
    );
  }
}
