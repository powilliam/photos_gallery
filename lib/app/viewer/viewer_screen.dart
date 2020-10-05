import 'package:flutter/material.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';
import 'package:photo_gallery/app/viewer/widgets/viewer_header.dart';

class ViewerScreen extends StatefulWidget {
  static MaterialPageRoute<ViewerScreen> route({@required data}) =>
      MaterialPageRoute<ViewerScreen>(
        builder: (_) => new ViewerScreen(data: data),
      );

  ViewerScreen({@required this.data}) : assert(data != null);

  final UnsplashImage data;

  @override
  _ViewerScreenState createState() => new _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              widget.data.urls.full,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return new Center(
                  child: CircularProgressIndicator(
                    value: progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes,
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: insets.top + 16,
            left: 12,
            right: 12,
            child: BlurredContainer(
                child: ViewerHeader(
                    name: widget.data.user.name,
                    source: widget.data.user.profileImage.small)),
          )
        ],
      ),
    );
  }
}
