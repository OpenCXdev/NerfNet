// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Query _$QueryFromJson(Map<String, dynamic> json) {
  return _Query.fromJson(json);
}

/// @nodoc
mixin _$Query {
  NerfModel get nerfModel => throw _privateConstructorUsedError;
  ExportType get exportOption => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueryCopyWith<Query> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryCopyWith<$Res> {
  factory $QueryCopyWith(Query value, $Res Function(Query) then) =
      _$QueryCopyWithImpl<$Res, Query>;
  @useResult
  $Res call(
      {NerfModel nerfModel, ExportType exportOption, DateTime? timestamp});
}

/// @nodoc
class _$QueryCopyWithImpl<$Res, $Val extends Query>
    implements $QueryCopyWith<$Res> {
  _$QueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nerfModel = null,
    Object? exportOption = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      nerfModel: null == nerfModel
          ? _value.nerfModel
          : nerfModel // ignore: cast_nullable_to_non_nullable
              as NerfModel,
      exportOption: null == exportOption
          ? _value.exportOption
          : exportOption // ignore: cast_nullable_to_non_nullable
              as ExportType,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QueryCopyWith<$Res> implements $QueryCopyWith<$Res> {
  factory _$$_QueryCopyWith(_$_Query value, $Res Function(_$_Query) then) =
      __$$_QueryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NerfModel nerfModel, ExportType exportOption, DateTime? timestamp});
}

/// @nodoc
class __$$_QueryCopyWithImpl<$Res> extends _$QueryCopyWithImpl<$Res, _$_Query>
    implements _$$_QueryCopyWith<$Res> {
  __$$_QueryCopyWithImpl(_$_Query _value, $Res Function(_$_Query) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nerfModel = null,
    Object? exportOption = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$_Query(
      nerfModel: null == nerfModel
          ? _value.nerfModel
          : nerfModel // ignore: cast_nullable_to_non_nullable
              as NerfModel,
      exportOption: null == exportOption
          ? _value.exportOption
          : exportOption // ignore: cast_nullable_to_non_nullable
              as ExportType,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Query extends _Query {
  _$_Query(
      {this.nerfModel = NerfModel.instantNGP,
      this.exportOption = ExportType.images,
      this.timestamp})
      : super._();

  factory _$_Query.fromJson(Map<String, dynamic> json) =>
      _$$_QueryFromJson(json);

  @override
  @JsonKey()
  final NerfModel nerfModel;
  @override
  @JsonKey()
  final ExportType exportOption;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'Query(nerfModel: $nerfModel, exportOption: $exportOption, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Query &&
            (identical(other.nerfModel, nerfModel) ||
                other.nerfModel == nerfModel) &&
            (identical(other.exportOption, exportOption) ||
                other.exportOption == exportOption) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nerfModel, exportOption, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QueryCopyWith<_$_Query> get copyWith =>
      __$$_QueryCopyWithImpl<_$_Query>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QueryToJson(
      this,
    );
  }
}

abstract class _Query extends Query {
  factory _Query(
      {final NerfModel nerfModel,
      final ExportType exportOption,
      final DateTime? timestamp}) = _$_Query;
  _Query._() : super._();

  factory _Query.fromJson(Map<String, dynamic> json) = _$_Query.fromJson;

  @override
  NerfModel get nerfModel;
  @override
  ExportType get exportOption;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_QueryCopyWith<_$_Query> get copyWith =>
      throw _privateConstructorUsedError;
}
