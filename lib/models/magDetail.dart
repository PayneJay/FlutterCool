import 'package:json_annotation/json_annotation.dart';
import "magDetailGroup.dart";
part 'magDetail.g.dart';

@JsonSerializable()
class MagDetail {
    MagDetail();

    bool success;
    List<MagDetailGroup> items;
    
    factory MagDetail.fromJson(Map<String,dynamic> json) => _$MagDetailFromJson(json);
    Map<String, dynamic> toJson() => _$MagDetailToJson(this);
}
