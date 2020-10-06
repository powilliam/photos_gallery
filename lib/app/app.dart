import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_bloc.dart';
import 'package:photo_gallery/app/featured/bloc/featured_event.dart';
import 'package:photo_gallery/app/featured/featured_screen.dart';
import 'package:photo_gallery/app/featured/repositories/featured_repository.dart';
import 'package:photo_gallery/app/helpers/colors.dart';
import 'package:photo_gallery/app/helpers/texts.dart';
import 'package:photo_gallery/app/search/bloc/search_bloc.dart';
import 'package:photo_gallery/app/search/repositories/search_repository.dart';
import 'package:photo_gallery/app/shared/services/unsplash_service.dart';

class App extends StatelessWidget {
  static const String _title = "Photos Gallery";

  App({@required this.unsplashService}) : assert(unsplashService != null);

  final UnsplashServiceContract unsplashService;

  @override
  Widget build(BuildContext context) {
    return new MultiBlocProvider(
        providers: [
          BlocProvider<FeaturedBloC>(
              create: (_) => FeaturedBloC(
                  repository:
                      FeaturedRepository(unsplashService: unsplashService))
                ..add(FeaturedListed(page: 1))),
          BlocProvider<SearchBloC>(
              create: (_) => SearchBloC(
                  repository:
                      SearchRepository(unsplashService: unsplashService)))
        ],
        child: MaterialApp(
          title: _title,
          theme: ThemeData(
            primaryColor: SecundaryDarkColor,
            accentColor: PrimaryAccentColor,
            backgroundColor: SecundaryDarkColor,
            scaffoldBackgroundColor: PrimaryDarkColor,
            fontFamily: "Poppins",
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: SecundaryDarkColor,
            ),
            textTheme: TextTheme(
                headline1: Headline1,
                bodyText1: BodyText1,
                bodyText2: BodyText2),
          ),
          home: FeaturedScreen(),
        ));
  }
}
