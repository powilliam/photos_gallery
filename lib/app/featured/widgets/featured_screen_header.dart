import 'package:flutter/material.dart';
import 'package:photo_gallery/app/search/search_screen.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class FeaturedScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;
    return new SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: insets.top + 12, left: 12, right: 12, bottom: 18),
          child: BlurredContainer(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text('Featured on Unsplash',
                        style: Theme.of(context).textTheme.bodyText1)),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(SearchScreen.route());
                  },
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
