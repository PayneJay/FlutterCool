// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodList _$PeriodListFromJson(Map<String, dynamic> json) {
  return PeriodList()
    ..success = json['success'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : MagChild.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..has_next = json['has_next'] as bool;
}

Map<String, dynamic> _$PeriodListToJson(PeriodList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
      'has_next': instance.has_next
    };
