import 'dart:io';

import 'package:cognitivestudio/repository/firebase_repository.dart';
import 'package:cognitivestudio/repository/firestore_path.dart';
import 'package:cognitivestudio/riverpod/firebase_provider.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class UploadViewModel extends ChangeNotifier {
  UploadViewModel(
    this.firebaseRepository,
  );
  final FirebaseRepository firebaseRepository;
  // final ImagePicker _picker = ImagePicker();
  List<PlatformFile> dataset = List.empty();
  // XFile? image;
  // File? image;
  // Uint8List? webImage;

  Future uploadImage() async {
    if (dataset.isNotEmpty) {
      // if (kIsWeb) {
      print('got web');
      await firebaseRepository.uploadFiles(
          storageBucketPath:
              FirebaseStoragePath.datasetBucket(DateTime.now().toString()),
          files: dataset);
    }
  }

  Future<void> pickMultipleFile() async {
    FilePickerResult? pickedFiles;
    if (kIsWeb) {
      // TODO make enum for extensions
      pickedFiles = await FilePickerWeb.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      );
    } else {
      pickedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4'],
      );
    }
    if (pickedFiles != null) {
      dataset = pickedFiles.files;
      print(dataset);
    }
    notifyListeners();
  }
}

final uploadViewModelProvider =
    ChangeNotifierProvider.autoDispose<UploadViewModel>((ref) {
  final firebaseRepository = ref.watch(firebaseRepositoryProvider);
  final uploadViewModel = UploadViewModel(firebaseRepository);
  return uploadViewModel;
});
