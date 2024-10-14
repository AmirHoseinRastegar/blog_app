import 'package:blog_app/core/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bookmark_bloc.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const AppLoader();
        }
        if(state is BookmarkLoaded){
        }
        return Scaffold(
          body: Column(
            children: [],
          ),
        );
      },
    );
  }
}
