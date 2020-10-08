import 'package:flutter/material.dart';
import 'package:photo_gallery/app/preview/preview_screen_controller.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class PreviewScreen extends StatelessWidget {
  static MaterialPageRoute route(
          {@required UnsplashImage image,
          @required PreviewScreenControllerContract controller}) =>
      new MaterialPageRoute(
          builder: (_) =>
              new PreviewScreen(image: image, controller: controller));

  PreviewScreen({@required this.image, @required this.controller})
      : assert(image != null),
        assert(controller != null);

  final UnsplashImage image;
  final PreviewScreenControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;
    return new Scaffold(
      key: controller.scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag: image.id,
              child: Image.network(image.urls.regular, fit: BoxFit.cover,
                  loadingBuilder: (_, widget, progress) {
                if (progress == null) return widget;
                return Center(
                  child: CircularProgressIndicator(
                      value: progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes,
                      backgroundColor: Theme.of(context).backgroundColor),
                );
              }),
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
                        NetworkImage(image.user.profileImage.large),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                      child: Text(image.user.name,
                          style: Theme.of(context).textTheme.bodyText1)),
                  SizedBox(width: 12),
                  IconButton(
                      icon: Icon(Icons.download_sharp,
                          size: 20, color: Colors.white),
                      onPressed: () async {
                        controller.scaffoldKey.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text("Downloading...",
                                style: Theme.of(context).textTheme.bodyText2),
                            behavior: SnackBarBehavior.floating,
                          ));
                        try {
                          await controller.download(image);
                          controller.scaffoldKey.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text("Done!",
                                  style: Theme.of(context).textTheme.bodyText2),
                              behavior: SnackBarBehavior.floating,
                            ));
                        } catch (e) {
                          print(e.toString());
                          controller.scaffoldKey.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(
                                  "Something went wrong when trying to download",
                                  style: Theme.of(context).textTheme.bodyText2),
                              behavior: SnackBarBehavior.floating,
                            ));
                        }
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
