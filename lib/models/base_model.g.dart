// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
      'id': instance.id,
    };

MateModel _$MateModelFromJson(Map<String, dynamic> json) => MateModel(
      mate: json['mate'] as String?,
      simple: json['simple'] == null
          ? null
          : SimpleModel.fromJson(json['simple'] as Map<String, dynamic>),
    )
      ..string1 = json['string1'] as String?
      ..string2 = json['string2'] as String?
      ..id = json['ID'] as String?
      ..title = json['title'] as String?
      ..trip = json['trip'] as String?;

Map<String, dynamic> _$MateModelToJson(MateModel instance) => <String, dynamic>{
      'string1': instance.string1,
      'string2': instance.string2,
      'ID': instance.id,
      'title': instance.title,
      'trip': instance.trip,
      'mate': instance.mate,
      'simple': instance.simple,
    };

SimpleModel _$SimpleModelFromJson(Map<String, dynamic> json) =>
    SimpleModel()..trip = json['trip'] as String?;

Map<String, dynamic> _$SimpleModelToJson(SimpleModel instance) =>
    <String, dynamic>{
      'trip': instance.trip,
    };
