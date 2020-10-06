import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_event.dart';
import 'package:photo_gallery/app/featured/widgets/featured_screen_image_list.dart';
import 'package:photo_gallery/app/featured/widgets/featured_screen_loading_indicator.dart';
import 'package:photo_gallery/app/featured/widgets/featured_screen_header.dart';
import 'package:photo_gallery/app/shared/widgets/scaffold_with_slivers.dart';

class FeaturedScreen extends StatelessWidget {
  static MaterialPageRoute route() =>
      new MaterialPageRoute(builder: (_) => new FeaturedScreen());

  @override
  Widget build(BuildContext context) {
    return new ScaffoldWithSlivers(
      slivers: <Widget>[
        FeaturedScreenHeader(),
        FeaturedScreenImageList(),
        FeaturedScreenLoadingIndicator()
      ],
      onEndReached: (count) {
        BlocProvider.of<FeaturedBloC>(context).add(FeaturedListed(
          page: count + 1,
        ));
      },
    );
  }
}
