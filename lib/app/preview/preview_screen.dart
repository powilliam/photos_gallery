import 'package:flutter/material.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class PreviewScreen extends StatelessWidget {
  static MaterialPageRoute route({@required UnsplashImage image}) =>
      new MaterialPageRoute(builder: (_) => new PreviewScreen(image: image));

  PreviewScreen({@required this.image}) : assert(image != null);

  final UnsplashImage image;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              image.urls.regular,
              fit: BoxFit.cover,
              loadingBuilder: (_, widget, progress) {
                if (progress == null) return widget;
                return Center(
                    child: CircularProgressIndicator(
                        value: progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes,
                        backgroundColor: Theme.of(context).backgroundColor));
              },
            ),
          ),
          Positioned(
            top: insets.top + 12,
            left: 12,
            right: 12,
            child: BlurredContainer(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    backgroundImage:
                        NetworkImage(image.user.profileImage.medium),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: Text(image.user.name,
                          style: Theme.of(context).textTheme.bodyText1)),
                  SizedBox(width: 12),
                  IconButton(
                      icon: Icon(Icons.download_sharp,
                          size: 20, color: Colors.white),
                      onPressed: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
