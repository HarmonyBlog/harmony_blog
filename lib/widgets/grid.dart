import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../model/post.dart';
import 'card.dart';

const double _minSpacingPx = 16;
const double _cardWidth = 360;

class PostsGrid extends StatelessWidget {
  PostsGrid({
    required List<Post> posts,
  }) : _posts = posts;

  final List<Post> _posts;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      // ResponsiveGridList crashes if desiredItemWidth + 2*minSpacing > Device window on Android
      desiredItemWidth: math.min(
          _cardWidth, MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
      minSpacing: _minSpacingPx,
      children: _posts
          .map((post) => PostCard(
                post: post,
              ))
          .toList(),
    );
  }
}
