import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StackOverEventPage extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: Container(
        color: Colors.red,
        child: Scrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: TestWidget(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    height: 44,
                    color: Colors.grey,
                    child: Text("$index"),
                  );
                }, childCount: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestWidget extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: 44,
          alignment: Alignment.center,
          color: Colors.yellow,
          child: Text("header"),
        ),
        Positioned(
          top: 44,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              // TODO: hitTest event
              print("mask did taped.");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
