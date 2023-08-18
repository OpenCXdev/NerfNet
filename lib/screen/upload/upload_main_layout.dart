import 'package:flutter/foundation.dart';
import 'package:cognitivestudio/screen/upload/upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';

class UploadMainLayout extends HookConsumerWidget {
  const UploadMainLayout({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(uploadViewModelProvider);
    return Center(
        child: Wrap(children: <Widget>[
      ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Gallery'),
          onTap: () async {
            await viewModel.selectImage();
            // Navigator.of(context).pop();
          }),
      ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Upload'),
          onTap: () async {
            await viewModel.uploadImage();
            // Navigator.of(context).pop();
          }),
      Center(
          child: viewModel.image != null
              ? kIsWeb
                  ? Image.network(viewModel.image!.path)
                  : Image.file(File(viewModel.image!.path))
              : const Text('Nothing selected'))
    ]));
  }
}
