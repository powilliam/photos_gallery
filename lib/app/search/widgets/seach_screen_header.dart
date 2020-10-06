import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/bloc/search_event.dart';
import 'package:photo_gallery/app/shared/widgets/blurred_container.dart';

class SearchScreenHeader extends StatefulWidget {
  @override
  _SearchScreenHeaderState createState() => new _SearchScreenHeaderState();
}

class _SearchScreenHeaderState extends State<SearchScreenHeader> {
  final TextEditingController _searchController = new TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;
    return new SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: insets.top + 12, left: 12, right: 12, bottom: 18),
          child: BlurredContainer(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    BlocProvider.of<SearchBloC>(context).add(SearchResetted());
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Search here',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Theme.of(context).accentColor)),
                    onSubmitted: (query) {
                      if (query.isEmpty &&
                          BlocProvider.of<SearchBloC>(context).state.query ==
                              query) {
                        return;
                      }
                      BlocProvider.of<SearchBloC>(context)
                          .add(SearchSubmitted(query: query));
                    },
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  icon: Icon(Icons.send, size: 20, color: Colors.white),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_searchController.text.isEmpty &&
                        BlocProvider.of<SearchBloC>(context).state.query ==
                            _searchController.text) {
                      return;
                    }
                    BlocProvider.of<SearchBloC>(context)
                        .add(SearchSubmitted(query: _searchController.text));
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
