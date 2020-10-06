import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_event.dart';
import 'package:photo_gallery/app/search/widgets/seach_screen_header.dart';
import 'package:photo_gallery/app/search/widgets/search_screen_image_list.dart';
import 'package:photo_gallery/app/search/widgets/search_screen_loading_indicator.dart';
import 'package:photo_gallery/app/shared/widgets/scaffold_with_slivers.dart';

class SearchScreen extends StatelessWidget {
  static MaterialPageRoute route() =>
      new MaterialPageRoute(builder: (_) => new SearchScreen());

  @override
  Widget build(BuildContext context) {
    return new ScaffoldWithSlivers(
      slivers: <Widget>[
        SearchScreenHeader(),
        SearchScreenImageList(),
        SearchScreenLoadingIndicator()
      ],
      onEndReached: (count) {
        BlocProvider.of<SearchBloC>(context).add(SearchLoaded(page: count + 1));
      },
    );
  }
}
