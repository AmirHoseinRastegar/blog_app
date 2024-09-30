import 'dart:io';

import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../auth/presentation/blocs/auth_bloc.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
