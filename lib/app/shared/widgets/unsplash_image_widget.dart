import 'package:flutter/material.dart';
import 'package:photo_gallery/app/preview/preview_screen.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class UnsplashImageWidget extends StatelessWidget {
  UnsplashImageWidget({Key key, @required this.image}) : super(key: key);

  final UnsplashImage image;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
                height: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(image.urls.regular),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        color: Theme.of(context).backgroundColor, width: 1))),
            Positioned(
              top: 16,
              right: 12,
              left: 12,
              child: BlurredContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      backgroundImage:
                          NetworkImage(image.user.profileImage.large),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(image.user.name,
                          style: Theme.of(context).textTheme.bodyText2),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(PreviewScreen.route(image: image));
        },
      ),
    );
  }
}
