import 'package:json_annotation/json_annotation.dart';
import "articles.dart";
import "cat.dart";
part 'articleList.g.dart';

@JsonSerializable()
class ArticleList {
    ArticleList();

    bool success;
    bool has_next;
    List<Articles> articles;
    num lang;
    num pn;
    Cat cats;
    num cid;
    
    factory ArticleList.fromJson(Map<String,dynamic> json) => _$ArticleListFromJson(json);
    Map<String, dynamic> toJson() => _$ArticleListToJson(this);
}
