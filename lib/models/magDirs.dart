import 'package:json_annotation/json_annotation.dart';
import "magGroup.dart";
part 'magDirs.g.dart';

@JsonSerializable()
class MagDirs {
    MagDirs();

    bool success;
    List<MagGroup> items;
    
    factory MagDirs.fromJson(Map<String,dynamic> json) => _$MagDirsFromJson(json);
    Map<String, dynamic> toJson() => _$MagDirsToJson(this);
}
