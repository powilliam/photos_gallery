import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_state.dart';
import 'package:photo_gallery/app/shared/widgets/unsplash_image_widget.dart';
import 'package:photo_gallery/app/shared/widgets/warning.dart';

class SearchScreenImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<SearchBloC, SearchState>(builder: (_, state) {
      if (state is SearchFailure) {
        return new SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: false,
          child: Warning(
              icon: Icons.error_outline, message: "Something went wrong"),
        );
      } else if (state is SearchEmpty) {
        return new SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: false,
          child: Warning(
              icon: Icons.image_not_supported,
              message: "There's no results for ${state.query}"),
        );
      } else if (state is SearchInitial) {
        return new SliverFillRemaining(
          fillOverscroll: false,
          hasScrollBody: false,
          child: Warning(
            icon: Icons.image_search,
            message: "You haven't searched anything yet",
          ),
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
