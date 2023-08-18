import 'dart:io';

import 'package:cognitivestudio/repository/firebase_repository.dart';
import 'package:cognitivestudio/repository/firestore_path.dart';
import 'package:cognitivestudio/riverpod/firebase_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UploadViewModel extends ChangeNotifier {
  UploadViewModel(
    this.firebaseRepository,
  );
  final FirebaseRepository firebaseRepository;
  final ImagePicker _picker = ImagePicker();
  // XFile? image;
  File? image;
  Uint8List? webImage;

  Future uploadImage() async {
    print(image);
    print(image!.path);
    if (image != null) {
      // if (kIsWeb) {
      webImage = await image!.readAsBytes();
      print('got web');
      await firebaseRepository.uploadImage(
          path: FirebaseStoragePath.dataset(DateTime.now().toString()),
          fileAsBytes: webImage!);
      // } else {
      //   // osImage = File(image!.path);
      //   await firebaseRepository.uploadImage(
      //       path: FirebaseStoragePath.dataset(DateTime.now().toString()), image: image);
      // }
    }
  }

  // select Image
  Future selectImage() async {
    final selectedimage = await _picker.pickImage(source: ImageSource.gallery);
    image = File(selectedimage!.path);
    notifyListeners();
  }
}

final uploadViewModelProvider =
    ChangeNotifierProvider.autoDispose<UploadViewModel>((ref) {
  final firebaseRepository = ref.watch(firebaseRepositoryProvider);
  final uploadViewModel = UploadViewModel(firebaseRepository);
  return uploadViewModel;
});

// Future imgFromGallery() async {
//   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//   setState(() {
//     if (pickedFile != null) {
//       _photo = File(pickedFile.path);
//       uploadFile();
//     } else {
//       print('No image selected.');
//     }
//   });
// }

// Future imgFromCamera() async {
//   final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//   setState(() {
//     if (pickedFile != null) {
//       _photo = File(pickedFile.path);
//       uploadFile();
//     } else {
//       print('No image selected.');
//     }
//   });
// }