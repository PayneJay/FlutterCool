import 'package:json_annotation/json_annotation.dart';
import "magChild.dart";
part 'periodList.g.dart';

@JsonSerializable()
class PeriodList {
    PeriodList();

    bool success;
    List<MagChild> items;
    bool has_next;
    
    factory PeriodList.fromJson(Map<String,dynamic> json) => _$PeriodListFromJson(json);
    Map<String, dynamic> toJson() => _$PeriodListToJson(this);
}
