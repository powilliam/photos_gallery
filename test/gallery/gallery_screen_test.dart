import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/gallery/gallery_screen.dart';

void main() {
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: GalleryScreen(),
    ));

    expect(find.text('Gallery Screen'), findsOneWidget);
  });
}
