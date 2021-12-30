import 'package:flutter/material.dart';
import 'package:harmony_blog/widgets/grid.dart';
import 'package:provider/provider.dart';

import 'package:harmony_blog/provider/appStateProvider.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Container(
        constraints: BoxConstraints(maxWidth: 1280),
        child: appState.isPostLoading
            ? CircularProgressIndicator()
            : appState.posts.isNotEmpty
                ? PostsGrid(
                    posts: appState.posts,
                  )
                : Text('Such Empty'),
      ),
    );
  }
}
