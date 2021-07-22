// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotTopicTag _$HotTopicTagFromJson(Map<String, dynamic> json) {
  return HotTopicTag(
    tagId: json['tagId'] as String,
    tagName: json['tagName'] as String,
  );
}

Map<String, dynamic> _$HotTopicTagToJson(HotTopicTag instance) =>
    <String, dynamic>{
      'tagId': instance.tagId,
      'tagName': instance.tagName,
    };

HotTopic _$HotTopicFromJson(Map<String, dynamic> json) {
  return HotTopic(
    labelId: json['labelId'] as String,
    labelName: json['labelName'] as String,
    quantity: json['quantity'] as int,
    topFlag: json['topFlag'] as bool,
    vehicleImageUrl: json['vehicleImageUrl'] as String,
    vehiclePrice: json['vehiclePrice'] as String,
    labelType: _$enumDecodeNullable(_$HotTopicTypeEnumMap, json['labelType'],
            unknownValue: HotTopicType.common) ??
        HotTopicType.common,
    labelSeries: json['labelSeries'] as String,
    spuId: json['spuId'] as String,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : HotTopic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HotTopicToJson(HotTopic instance) => <String, dynamic>{
      'labelId': instance.labelId,
      'labelName': instance.labelName,
      'quantity': instance.quantity,
      'topFlag': instance.topFlag,
      'labelType': _$HotTopicTypeEnumMap[instance.labelType],
      'labelSeries': instance.labelSeries,
      'vehicleImageUrl': instance.vehicleImageUrl,
      'vehiclePrice': instance.vehiclePrice,
      'spuId': instance.spuId,
      'tags': instance.tags,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$HotTopicTypeEnumMap = {
  HotTopicType.common: 'common',
  HotTopicType.series: 'series',
  HotTopicType.all: 'all',
};
