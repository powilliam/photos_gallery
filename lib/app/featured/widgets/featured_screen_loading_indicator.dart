import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_state.dart';

class FeaturedScreenLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SliverFillRemaining(
        fillOverscroll: true,
        hasScrollBody: false,
        child: BlocBuilder<FeaturedBloC, FeaturedState>(builder: (_, state) {
          if (state is FeaturedLoadInProgress) {
            return new Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
              )),
            );
          }
          return SizedBox();
        }));
  }
}
