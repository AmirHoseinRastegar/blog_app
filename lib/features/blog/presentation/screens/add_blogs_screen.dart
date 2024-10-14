import 'dart:io';

import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/add_blog_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import '../../../../core/theme/pallet.dart';


class AddBlogsScreen extends StatefulWidget {
  static rout() => MaterialPageRoute(
        builder: (context) => const AddBlogsScreen(),
      );

  const AddBlogsScreen({super.key});

  @override
  State<AddBlogsScreen> createState() => _AddBlogsScreenState();
}

class _AddBlogsScreenState extends State<AddBlogsScreen> {
  final TextEditingController _blogTitleController = TextEditingController();
  final TextEditingController _blogDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  List<String> topics = [];

  @override
  void dispose() {
    super.dispose();
    _blogDescriptionController.dispose();
    _blogTitleController.dispose();
  }

  void pickImageFunc() async {
    final imageChosen = await pickImage();
    if (imageChosen != null) {
      setState(() {
        image = imageChosen;
      });
    }
  }

  void uploadBlog() {
    if (_formKey.currentState!.validate() && image != null ||
        topics.isNotEmpty) {
      final posterId =
          (context.read<PersistLoginCubit>().state as IsLoggedIn).user.id;
      BlocProvider.of<BlogBloc>(context).add(UploadBlogsEvent(
          title: _blogTitleController.text.trim(),
          content: _blogDescriptionController.text.trim(),
          image: image!,
          posterId: posterId,
          topics: topics));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUploadSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } else if (state is BlogError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if(state is BlogLoading) {
            return const AppLoader();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: pickImageFunc,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              pickImageFunc();
                            },
                            child: DottedBorder(
                              color: Pallet.borderColor,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Add Your Image',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      child: Row(
                        children: [
                          'technology',
                          'business',
                          'entertainment',
                          'sports',
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (topics.contains(e)) {
                                      topics.remove(e);
                                    } else {
                                      topics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    color: topics.contains(e)
                                        ? const MaterialStatePropertyAll(
                                            Pallet.gradient1)
                                        : null,
                                    label: Text(
                                      e,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    side: topics.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: Pallet.borderColor),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AddBlogTextField(
                      controller: _blogTitleController,
                      hintText: 'Title',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AddBlogTextField(
                      controller: _blogDescriptionController,
                      hintText: 'Description',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
