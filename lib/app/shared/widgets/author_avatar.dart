import 'package:flutter/material.dart';

class AuthorAvatar extends StatelessWidget {
  AuthorAvatar({Key key, @required this.name, @required this.source})
      : assert(name != null),
        assert(source != null),
        super(key: key);

  final String source;
  final String name;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(source),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        SizedBox(width: 12),
        Text(name, style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }
}
