import 'package:flutter/material.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/viewer/viewer_screen.dart';
import 'package:photo_gallery/app/shared/widgets/author_avatar.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class GalleryImage extends StatelessWidget {
  GalleryImage({Key key, this.data})
      : assert(data != null),
        super(key: key);

  final UnsplashImage data;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
                height: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(data.urls.regular),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        color: Theme.of(context).backgroundColor, width: 1))),
            Positioned(
              top: 16,
              right: 12,
              left: 12,
              child: BlurredContainer(
                child: AuthorAvatar(
                  name: data.user.name,
                  source: data.user.profileImage.medium,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(ViewerScreen.route(data: data));
        },
      ),
    );
  }
}
