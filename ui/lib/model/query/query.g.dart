// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Query _$$_QueryFromJson(Map<String, dynamic> json) => _$_Query(
      nerfModel: $enumDecodeNullable(_$NerfModelEnumMap, json['nerfModel']) ??
          NerfModel.instantNGP,
      exportOption:
          $enumDecodeNullable(_$ExportTypeEnumMap, json['exportOption']) ??
              ExportType.images,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$_QueryToJson(_$_Query instance) => <String, dynamic>{
      'nerfModel': _$NerfModelEnumMap[instance.nerfModel]!,
      'exportOption': _$ExportTypeEnumMap[instance.exportOption]!,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

const _$NerfModelEnumMap = {
  NerfModel.instantNGP: 'instantNGP',
  NerfModel.neuralangelo: 'neuralangelo',
  NerfModel.gaussSplattering: 'gaussSplattering',
  NerfModel.nerFacto: 'nerFacto',
};

const _$ExportTypeEnumMap = {
  ExportType.mesh: 'mesh',
  ExportType.pcd: 'pcd',
  ExportType.images: 'images',
};
