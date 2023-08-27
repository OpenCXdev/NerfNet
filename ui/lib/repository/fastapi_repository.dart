import 'dart:convert';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cognitivestudio/model/query/query.dart';
import 'package:http_parser/http_parser.dart';

class FastApiRepository {
  // FastApiRepository({required this.firestore, required this.storage});
  FastApiRepository();
  // final FirebaseFirestore firestore;
  // final FirebaseStorage storage;

  final String serviceURL = "127.0.0.1:8000";

  Future<List<Query>> getQuery(id) async {
    List<Query> queries = [];
    var response = await http.get(Uri.http(serviceURL, 'queries/$id'),
        headers: {"Accept": "application/json"});
    var responseData = json.decode(response.body);
    for (var queryData in responseData) {
      queries.add(Query.fromJson(queryData));
    }

    return queries;
  }

  Future<void> uploadFiles(
      {required Query query, required List<PlatformFile> dataset}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.http(serviceURL, '/upload/'),
    )
      ..fields['method'] = query.nerfModel.name
      ..fields['iters'] = '10000';

    // Add the files to the request
    for (final file in dataset) {
      request.files.add(http.MultipartFile.fromBytes('files', file.bytes!,
          contentType: MediaType('image', 'png'), filename: file.name));
    }
    print(request.files);
    print(request.fields);

    // Send the request
    var response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print(
          'Error uploading file: ${response.statusCode} | ${response.reasonPhrase}');
    }
  }
}
