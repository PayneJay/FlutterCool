import 'package:json_annotation/json_annotation.dart';
import "magDetailChild.dart";
part 'magDetailGroup.g.dart';

@JsonSerializable()
class MagDetailGroup {
    MagDetailGroup();

    String name;
    List<MagDetailChild> items;
    
    factory MagDetailGroup.fromJson(Map<String,dynamic> json) => _$MagDetailGroupFromJson(json);
    Map<String, dynamic> toJson() => _$MagDetailGroupToJson(this);
}
