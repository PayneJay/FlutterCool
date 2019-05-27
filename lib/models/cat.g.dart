// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) {
  return Cat()
    ..id = json['id'] as num
    ..desc = json['desc'] as String
    ..seo = json['seo'] as String
    ..exclude = json['exclude'] as List
    ..include = json['include'] as List;
}

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'seo': instance.seo,
      'exclude': instance.exclude,
      'include': instance.include
    };
