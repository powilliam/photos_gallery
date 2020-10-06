import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_state.dart';
import 'package:photo_gallery/app/shared/widgets/unsplash_image_widget.dart';
import 'package:photo_gallery/app/shared/widgets/warning.dart';

class FeaturedScreenImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<FeaturedBloC, FeaturedState>(builder: (_, state) {
      if (state is FeaturedFailure) {
        return new SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: false,
          child: Warning(
              icon: Icons.error_outline,
              message:
                  "Something went wrong during some process \n Try again later"),
        );
      }
      return new SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
          return new Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: UnsplashImageWidget(
              image: state.images[index],
            ),
          );
        }, childCount: state.images.length),
      );
    });
  }
}
