import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/core/theme/pallet.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/snakbar.dart';

class MainBlogScreen extends StatefulWidget {
  const MainBlogScreen({super.key});

  static rout() => MaterialPageRoute(
        builder: (context) => const MainBlogScreen(),
      );

  @override
  State<MainBlogScreen> createState() => _MainBlogScreenState();
}

class _MainBlogScreenState extends State<MainBlogScreen> {
  @override
  void initState() {
    super.initState();

    context.read<BlogBloc>().add(GetAllBlogsEvent());

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add New Blog'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_blog');
                },
                icon: const Icon(CupertinoIcons.add_circled))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogError) {
              return snakBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const AppLoader();
            }
            if (state is BlogGetAllBlogsSuccess) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                      color: index % 3 == 0
                          ? Pallet.gradient1
                          : index % 3 == 1
                              ? Pallet.gradient2
                              : Pallet.gradient3,
                      blog: blog);
                },
                itemCount: state.blogs.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
