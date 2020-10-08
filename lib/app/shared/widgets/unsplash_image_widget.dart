import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/app/preview/preview_screen.dart';
import 'package:photo_gallery/app/preview/preview_screen_controller.dart';
import 'package:photo_gallery/app/preview/repositories/preview_repository.dart';
import 'package:photo_gallery/app/shared/models/unsplash_image.dart';
import 'package:photo_gallery/app/shared/services/download_service.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

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
                  return Center(
                    child: CircularProgressIndicator(
                        value: progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes,
                        backgroundColor: Theme.of(context).backgroundColor),
                  );
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
              controller: PreviewScreenController(
                  repository: PreviewRepository(
                      downloadService: DownloadService(
                          dio: Dio(BaseOptions(
                              responseType: ResponseType.bytes)))))));
        },
      ),
    );
  }
}
