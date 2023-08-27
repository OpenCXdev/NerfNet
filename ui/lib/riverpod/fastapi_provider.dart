import 'package:cognitivestudio/repository/fastapi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fastApiRepositoryProvider = Provider<FastApiRepository>((ref) {
  return FastApiRepository();
});
