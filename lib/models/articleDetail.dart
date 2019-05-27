import 'package:json_annotation/json_annotation.dart';
import "article.dart";
part 'articleDetail.g.dart';

@JsonSerializable()
class ArticleDetail {
    ArticleDetail();

    bool success;
    Article article;
    String like;
    Map<String,dynamic> site;
    
    factory ArticleDetail.fromJson(Map<String,dynamic> json) => _$ArticleDetailFromJson(json);
    Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}
