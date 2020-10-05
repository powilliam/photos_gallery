import 'package:flutter/material.dart';
import 'package:photo_gallery/app/shared/widgets/author_avatar.dart';

class ViewerHeader extends StatelessWidget {
  ViewerHeader({Key key, @required this.name, @required this.source})
      : assert(name != null),
        assert(source != null),
        super(key: key);

  final String name;
  final String source;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            SizedBox(
              width: 4,
            ),
            AuthorAvatar(
              name: name,
              source: source,
            )
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.download_sharp,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
