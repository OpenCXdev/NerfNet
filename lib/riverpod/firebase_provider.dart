import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognitivestudio/repository/firebase_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireStoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final firebaseRepositoryProvider = Provider<FirebaseRepository>((ref) {
  final firestore = ref.watch(fireStoreProvider);
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  return FirebaseRepository(firestore: firestore, storage: firebaseStorage);
});
