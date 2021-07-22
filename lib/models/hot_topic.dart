import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_topic.g.dart';

enum HotTopicType {
  @JsonValue(HotTopic.common)
  common,
  @JsonValue(HotTopic.series)
  series,
  @JsonValue(HotTopic.all)
  all,
}

@JsonSerializable()
class HotTopicTag extends Equatable {
  final String tagId;
  final String tagName;

  HotTopicTag({
    this.tagId,
    this.tagName,
  });

  factory HotTopicTag.fromJson(Map<String, dynamic> json) =>
      _$HotTopicTagFromJson(json);

  Map<String, dynamic> toJson() => _$HotTopicTagToJson(this);

  @override
  List<Object> get props => [
        tagId,
        tagName,
      ];
}

@JsonSerializable()
// ignore: must_be_immutable
class HotTopic extends Equatable {
  static const String common = 'common';
  static const String series = 'series';
  static const String all = 'all';

  final String labelId;
  final String labelName;
  final int quantity;
  final bool topFlag;
  @JsonKey(
    defaultValue: HotTopicType.common,
    unknownEnumValue: HotTopicType.common,
  )
  final HotTopicType labelType;
  final String labelSeries;
  final String vehicleImageUrl;
  final String vehiclePrice;
  final String spuId;
  final List<HotTopic> tags;

  String _topicName = '';
  String get topicName {
    if (_topicName.isEmpty) {
      _topicName = labelName?.replaceAll('#', '') ?? '-';
    }
    return _topicName;
  }

  HotTopic({
    this.labelId,
    this.labelName,
    this.quantity,
    this.topFlag,
    this.vehicleImageUrl,
    this.vehiclePrice,
    this.labelType,
    this.labelSeries,
    this.spuId,
    this.tags = const [],
  });

  @override
  List<Object> get props => [
        labelId,
        labelName,
        quantity,
        topFlag,
        vehicleImageUrl,
        vehiclePrice,
        labelType,
        labelSeries,
        spuId,
        tags,
      ];

  factory HotTopic.fromJson(Map<String, dynamic> json) =>
      _$HotTopicFromJson(json);

  Map<String, dynamic> toJson() => _$HotTopicToJson(this);

  HotTopic copyWith({
    String labelId,
    String labelName,
    int quantity,
    String quantityLabel,
    bool topFlag,
    String vehicleImageUrl,
    String vehiclePrice,
    HotTopicType labelType,
    String labelSeries,
    String spuId,
    List<HotTopic> tags,
  }) =>
      HotTopic(
        labelId: labelId ?? this.labelId,
        labelName: labelName ?? this.labelName,
        quantity: quantity ?? this.quantity,
        topFlag: topFlag ?? this.topFlag,
        vehicleImageUrl: vehicleImageUrl ?? this.vehicleImageUrl,
        vehiclePrice: vehiclePrice ?? this.vehiclePrice,
        labelType: labelType ?? this.labelType,
        labelSeries: labelSeries ?? this.labelSeries,
        spuId: spuId ?? this.spuId,
        tags: tags ?? this.tags,
      );
}
