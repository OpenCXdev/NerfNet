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
    return Column(children: <Widget>[
      ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Gallery'),
          onTap: () async {
            await viewModel.pickMultipleFile();
            // Navigator.of(context).pop();
          }),
      ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Upload'),
          onTap: () async {
            await viewModel.uploadImage();
            // Navigator.of(context).pop();
          }),
      Expanded(
        flex: 8,
        child: viewModel.dataset.isEmpty
            ? const Text('Nothing selected')
            : Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        itemCount: viewModel.dataset.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: kIsWeb
                                  ? Image.memory(
                                      viewModel.dataset[index].bytes!,
                                      height: 0.3 *
                                          MediaQuery.of(context).size.height,
                                      scale: 0.5,
                                    )
                                  : Image.file(
                                      File(viewModel.dataset[index].path!)));
                        }),
                  ),
                ],
              ),
      )
    ]);
  }
}
