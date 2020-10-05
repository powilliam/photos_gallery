import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_event.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_state.dart';
import 'package:photo_gallery/app/gallery/widgets/gallery_image.dart';
import 'package:photo_gallery/app/gallery/widgets/gallery_search_input.dart';
import 'package:photo_gallery/app/gallery/widgets/gallery_title.dart';

class GalleryScreen extends StatefulWidget {
  static MaterialPageRoute<GalleryScreen> route() =>
      MaterialPageRoute<GalleryScreen>(builder: (_) => new GalleryScreen());

  @override
  _GalleryScreenState createState() => new _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int page = 1;
  bool isScrolling = false;
  String query;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 350) {
        setState(() {
          isScrolling = true;
        });
      } else {
        setState(() {
          isScrolling = false;
        });
      }
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        final GalleryState state = BlocProvider.of<GalleryBloC>(context).state;
        final bool isSearching = state.isSearching;
        if (!isSearching) {
          BlocProvider.of<GalleryBloC>(context)
              .add(GalleryGetted(page: page + 1, limit: 10));
        } else {
          BlocProvider.of<GalleryBloC>(context).add(GallerySearched(
              query: query ?? state.query, page: page + 1, limit: 10));
        }
        setState(() {
          page++;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets insets = MediaQuery.of(context).viewPadding;

    return new Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(
                    top: insets.top + 18, left: 16, right: 16, bottom: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GallerySearchInput(
                      controller: _searchController,
                      onSubmitted: (String value) {
                        if (value.isEmpty) return;
                        setState(() {
                          page = 1;
                          query = value;
                        });
                        BlocProvider.of<GalleryBloC>(context).add(
                            GallerySearched(query: query, page: 1, limit: 10));
                        _searchController.clear();
                      },
                    ),
                    SizedBox(height: 48),
                    GalleryTitle(
                      title: "${query ?? "Featured"} on Unsplash",
                    )
                  ],
                ),
              ),
            ]),
          ),
          BlocBuilder<GalleryBloC, GalleryState>(builder: (_, state) {
            return new SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                return new GalleryImage(
                    key: Key(state.images[i].id), data: state.images[i]);
              }, childCount: state.images.length),
            );
          }),
          BlocBuilder<GalleryBloC, GalleryState>(builder: (context, state) {
            return new SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                  ),
                )
              ]),
            );
          }, buildWhen: (_, newState) {
            return newState is GalleryStateLoadInProgress;
          })
        ],
      ),
      floatingActionButton: isScrolling
          ? FloatingActionButton(
              mini: true,
              child: Icon(
                Icons.arrow_upward,
                size: 16,
                color: Colors.white,
              ),
              onPressed: () async {
                await _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceOut);
              })
          : null,
    );
  }
}
