import 'dart:io';

import 'package:cognitivestudio/model/query/query.dart';
import 'package:cognitivestudio/model/utils/enums.dart';
import 'package:cognitivestudio/repository/fastapi_repository.dart';
import 'package:cognitivestudio/repository/firebase_repository.dart';
import 'package:cognitivestudio/repository/firestore_path.dart';
import 'package:cognitivestudio/riverpod/fastapi_provider.dart';
import 'package:cognitivestudio/riverpod/firebase_provider.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class UploadViewModel extends ChangeNotifier {
  UploadViewModel(
    this.firebaseRepository,
    this.fastApiRepository,
  );
  final FirebaseRepository firebaseRepository;
  final FastApiRepository fastApiRepository;
  List<PlatformFile> dataset = List.empty();
  NerfModel selectedModel = NerfModel.instantNGP;
  ExportType selectedExportType = ExportType.images;

  void setNerfModel(NerfModel? modelType) {
    selectedModel = modelType ?? NerfModel.instantNGP;
    notifyListeners();
  }

  void setExportType(ExportType? exportType) {
    selectedExportType = exportType ?? ExportType.images;
    notifyListeners();
  }

  Future uploadQuery(DateTime timestamp) async {
    Query query = Query.fromJson({
      'nerfModel': selectedModel.name,
      'exportOption': selectedExportType.name,
      'timestamp': timestamp.toString(),
    });
    await firebaseRepository.setData(
        path: FirestoreDocPath.query(timestamp.toString()),
        data: query.toJson());
  }

  Future uploadImage(DateTime timestamp) async {
    if (dataset.isNotEmpty) {
      // if (kIsWeb) {
      // print('got web');
      await firebaseRepository.uploadFiles(
          storageBucketPath:
              FirebaseStoragePath.datasetBucket(timestamp.toString()),
          files: dataset);
    }
  }

  Future uploadFAJob(
      {required Query query, required List<PlatformFile> dataset}) async {
    await fastApiRepository.uploadFiles(query: query, dataset: dataset);
  }

  Future uploadJob() async {
    final currentTimestamp = DateTime.now();
    // await uploadQuery(currentTimestamp);
    // await uploadImage(currentTimestamp);
    Query query = Query.fromJson({
      'nerfModel': selectedModel.name,
      'exportOption': selectedExportType.name,
      'timestamp': currentTimestamp.toString(),
    });
    await uploadFAJob(query: query, dataset: dataset);
  }

  Future<void> pickMultipleFile() async {
    FilePickerResult? pickedFiles;
    if (kIsWeb) {
      // TODO make enum for extensions
      pickedFiles = await FilePickerWeb.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'txt'],
      );
    } else {
      pickedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4', 'txt'],
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
  final fastApiRepository = ref.watch(fastApiRepositoryProvider);
  final uploadViewModel =
      UploadViewModel(firebaseRepository, fastApiRepository);
  return uploadViewModel;
});
