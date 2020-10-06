import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_state.dart';

class SearchScreenLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SliverFillRemaining(
        fillOverscroll: true,
        hasScrollBody: false,
        child: BlocBuilder<SearchBloC, SearchState>(builder: (_, state) {
          if (state is SearchLoadInProgress) {
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
