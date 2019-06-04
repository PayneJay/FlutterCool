import 'package:json_annotation/json_annotation.dart';
import "topicChild.dart";
part 'topicSearch.g.dart';

@JsonSerializable()
class TopicSearch {
    TopicSearch();

    bool success;
    List<TopicChild> topics;
    
    factory TopicSearch.fromJson(Map<String,dynamic> json) => _$TopicSearchFromJson(json);
    Map<String, dynamic> toJson() => _$TopicSearchToJson(this);
}
