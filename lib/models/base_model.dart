import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

abstract class BaseModel extends Equatable {
  final String? id;
  final String? title;

  BaseModel({
    this.id,
    this.title,
  });

  @override
  List<Object?> get props => [
        id,
        title,
      ];
}

@JsonSerializable()
class TripModel extends BaseModel {
  TripModel({
    String? id,
  }) : super(
          id: id,
        );

  factory TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);
  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}

mixin BaseMixin {
  late final String? string1;
  late final String? string2;
}

mixin ArticleMixin {
  @JsonKey(name: 'ID')
  late final String? id;
  late final String? title;
}

mixin TripMixin {
  late final String? trip;
}

@JsonSerializable()
class MateModel extends Equatable with BaseMixin, ArticleMixin, TripMixin {
  final String? mate;
  final SimpleModel? simple;

  MateModel({
    this.mate,
    this.simple,
  });

  factory MateModel.fromJson(Map<String, dynamic> json) => _$MateModelFromJson(json);
  Map<String, dynamic> toJson() => _$MateModelToJson(this);

  @override
  List<Object?> get props => [
        mate,
        string1,
        string2,
      ];
}

@JsonSerializable()
class SimpleModel extends Equatable with TripMixin {
  SimpleModel();

  factory SimpleModel.fromJson(Map<String, dynamic> json) => _$SimpleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleModelToJson(this);

  @override
  List<Object?> get props => [];

  SimpleModel copyWith({
    String? trip,
  }) {
    return SimpleModel()..trip = trip;
  }
}

void main() {
  // Iterable;
  // List;
  // Map;

  SimpleModel().copyWith(trip: 'tirp');
  final mate = MateModel(
    mate: 'mate',
  );
  // mate.id = '1';
  // mate.id = '2';
  // mate.mate = '123';

  doPrint(mate);
}

void doPrint(ArticleMixin article) {
  print(article.id);
}
