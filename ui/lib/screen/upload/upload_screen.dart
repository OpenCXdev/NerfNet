import 'package:cognitivestudio/screen/upload/upload_main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UploadScreen extends HookWidget {
  const UploadScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeRF Net'),
      ),
      body: const UploadMainLayout(),
    );
  }
}
