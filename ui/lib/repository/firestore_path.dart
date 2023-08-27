// ignore_for_file: avoid_classes_with_only_static_members

class FirestoreDocPath {
  static String query(String queryId) => 'query/$queryId';
}
// class FirestoreCollectionPath {
//   static String relatedUsers(String userId) =>
//       'users/$userId/related_users';
// }

class FirebaseStoragePath {
  static String datasetBucket(String queryId) => 'datasets/$queryId';
}
