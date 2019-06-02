import 'package:json_annotation/json_annotation.dart';

part 'magDetailChild.g.dart';

@JsonSerializable()
class MagDetailChild {
    MagDetailChild();

    String url;
    String title;
    String meta;
    num type;
    
    factory MagDetailChild.fromJson(Map<String,dynamic> json) => _$MagDetailChildFromJson(json);
    Map<String, dynamic> toJson() => _$MagDetailChildToJson(this);
}
