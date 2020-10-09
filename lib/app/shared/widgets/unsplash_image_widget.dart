import 'package:flutter/material.dart';
import 'package:photo_gallery/app/preview/preview_screen.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';
import 'package:shimmer/shimmer.dart';

class UnsplashImageWidget extends StatelessWidget {
  UnsplashImageWidget({Key key, @required this.image}) : super(key: key);

  final UnsplashImage image;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 320,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border:
              Border.all(color: Theme.of(context).backgroundColor, width: 1)),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Hero(
                tag: image.id,
                child: Image.network(image.urls.regular, fit: BoxFit.cover,
                    loadingBuilder: (_, widget, progress) {
                  if (progress == null) return widget;
                  return new Shimmer.fromColors(
                      baseColor: Colors.grey[900],
                      highlightColor: Theme.of(context).backgroundColor,
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                      ));
                }),
              ),
            )),
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
          Navigator.of(context).push(PreviewScreen.route(
            image: image,
          ));
        },
      ),
    );
  }
}
