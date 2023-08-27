// todo create query model in fireStore
import 'package:cognitivestudio/model/utils/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'query.freezed.dart';
part 'query.g.dart';

@freezed
class Query with _$Query {
  factory Query({
    @Default(NerfModel.instantNGP) NerfModel nerfModel,
    @Default(ExportType.images) ExportType exportOption,
    DateTime? timestamp,
  }) = _Query;

  const Query._();

  factory Query.init() => Query(
        nerfModel: NerfModel.instantNGP,
        exportOption: ExportType.images,
        timestamp: DateTime.now(),
      );

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
}
