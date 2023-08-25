import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepository {
  FirebaseRepository(
      {
      //   required this.deviceToken,
      required this.firestore,
      required this.storage});
  // final String deviceToken;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String path,
  }) {
    return firestore.collection(path).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
  }) {
    return firestore.doc(path).get();
  }

  Future<void> deleteDocument({
    required String path,
  }) async {
    await firestore.doc(path).delete();
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    final reference = firestore.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    await reference.update(data);
  }

  // Future<void> uploadImage({
  //   required String path,
  //   required dynamic fileAsBytes,
  // }) async {
  //   final reference = storage.ref().child(path);
  //   await reference.putFile(fileAsBytes);
  // }

  Future<String>? uploadFile(
      {required String path, required Uint8List imageAsBytes}) async {
    try {
      final reference = storage.ref().child(path);
      await reference.putData(imageAsBytes);
      return await reference.getDownloadURL();
    } catch (error) {
      print('Error uploading image $path');
    }
    return Future<String>.value(null);
  }

  Future<void> uploadFiles(
      {required String storageBucketPath,
      required List<PlatformFile> files}) async {
    for (int i = 0; i < files.length; i++) {
      String imagePath = "$storageBucketPath/${files[i].name}";
      final url =
          await uploadFile(path: imagePath, imageAsBytes: files[i].bytes!);
      print('$url \n');
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> docSnapshots({
    required String path,
  }) {
    return firestore.doc(path).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> collectionSnapshots({
    required String path,
  }) {
    return firestore.collection(path).snapshots();
  }
}
