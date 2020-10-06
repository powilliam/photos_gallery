import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  Warning({Key key, @required this.icon, @required this.message})
      : assert(icon != null),
        assert(message != null),
        super(key: key);

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 52, color: Theme.of(context).accentColor),
        SizedBox(height: 12),
        Text(message,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Theme.of(context).accentColor))
      ],
    );
  }
}
