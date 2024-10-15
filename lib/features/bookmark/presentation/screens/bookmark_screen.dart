import 'dart:js';

import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../blog/presentation/widgets/blog_card.dart';
import '../bloc/bookmark_bloc.dart';

class BookmarksScreen extends StatelessWidget {
  static rout() =>
      MaterialPageRoute(builder: (context) => const BookmarksScreen());
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookMarkLoading) {
          return const AppLoader();
        } else if (state is BookMarkLoaded) {
          return ListView.builder(
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final blog = state.bookmarks[index];
              return ListTile(
                title: Text(blog.title),
              );
            },
          );
        } else if (state is BookMarkError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
