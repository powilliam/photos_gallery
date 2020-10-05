import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_bloc.dart';
import 'package:photo_gallery/app/gallery/bloc/gallery_event.dart';
import 'package:photo_gallery/app/gallery/gallery_screen.dart';
import 'package:photo_gallery/app/gallery/repositories/gallery_repository.dart';
import 'package:photo_gallery/app/helpers/colors.dart';
import 'package:photo_gallery/app/helpers/texts.dart';

class App extends StatelessWidget {
  static const String _title = "Photos Gallery";

  App({@required this.repository}) : assert(repository != null);

  final GalleryRepositoryContract repository;

  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
        create: (_) => GalleryBloC(repository: repository)
          ..add(GalleryGetted(page: 1, limit: 10)),
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
                  bodyText2: BodyText2)),
          home: GalleryScreen(),
        ));
  }
}
