import 'package:flutter_test/flutter_test.dart';
import 'package:photo_gallery/app/app.dart';

void main() {
  testWidgets('Should be able to render', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('Gallery Screen'), findsOneWidget);
  });
}
