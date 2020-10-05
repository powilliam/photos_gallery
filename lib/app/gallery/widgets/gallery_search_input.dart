import 'package:flutter/material.dart';
import 'package:photo_gallery/app/helpers/colors.dart';

class GallerySearchInput extends StatelessWidget {
  GallerySearchInput(
      {Key key, this.controller, this.onChanged, this.onSubmitted})
      : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    final TextStyle _textStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(color: PrimaryAccentColor);

    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: PrimaryAccentColor,
            ),
            hintText: 'Search',
            hintStyle: _textStyle,
            border: InputBorder.none),
        style: _textStyle,
      ),
    );
  }
}
