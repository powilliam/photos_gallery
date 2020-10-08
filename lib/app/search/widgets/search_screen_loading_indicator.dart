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
          return new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(48),
                  child: (state is SearchLoadInProgress
                      ? CircularProgressIndicator()
                      : SizedBox())),
              SizedBox(height: 24)
            ],
          );
        }));
  }
}
