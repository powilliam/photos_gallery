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
          return new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(48),
                  child: (state is FeaturedLoadInProgress
                      ? CircularProgressIndicator()
                      : SizedBox())),
              SizedBox(height: 24)
            ],
          );
        }));
  }
}
