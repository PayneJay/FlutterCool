import 'package:json_annotation/json_annotation.dart';
import "magChild.dart";
part 'magGroup.g.dart';

@JsonSerializable()
class MagGroup {
    MagGroup();

    String name;
    num type;
    List<MagChild> items;
    
    factory MagGroup.fromJson(Map<String,dynamic> json) => _$MagGroupFromJson(json);
    Map<String, dynamic> toJson() => _$MagGroupToJson(this);
}
