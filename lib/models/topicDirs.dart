import 'package:json_annotation/json_annotation.dart';
import "topicGroup.dart";
part 'topicDirs.g.dart';

@JsonSerializable()
class TopicDirs {
    TopicDirs();

    bool success;
    List<TopicGroup> items;
    
    factory TopicDirs.fromJson(Map<String,dynamic> json) => _$TopicDirsFromJson(json);
    Map<String, dynamic> toJson() => _$TopicDirsToJson(this);
}
