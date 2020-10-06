import 'package:flutter/material.dart';

class ScaffoldWithSlivers extends StatefulWidget {
  ScaffoldWithSlivers({Key key, this.slivers, this.onEndReached})
      : assert(slivers != null),
        super(key: key);

  final List<Widget> slivers;
  final Function(int count) onEndReached;

  @override
  _ScaffoldWithSliverState createState() => new _ScaffoldWithSliverState();
}

class _ScaffoldWithSliverState extends State<ScaffoldWithSlivers> {
  final ScrollController _scrollController = new ScrollController();

  bool _isScrolling = false;
  int _reachedCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 220) {
        setState(() {
          _isScrolling = true;
        });
      } else {
        setState(() {
          _isScrolling = false;
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        widget.onEndReached(_reachedCount);
        setState(() {
          _reachedCount++;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
          controller: _scrollController, slivers: widget.slivers),
      floatingActionButton: _isScrolling
          ? FloatingActionButton(
              mini: true,
              child: Icon(Icons.arrow_upward, size: 16, color: Colors.white),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);
              })
          : null,
    );
  }
}
