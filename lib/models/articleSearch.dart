import 'package:json_annotation/json_annotation.dart';
import "articles.dart";
part 'articleSearch.g.dart';

@JsonSerializable()
class ArticleSearch {
    ArticleSearch();

    bool success;
    List<Articles> articles;
    num pn;
    num limit;
    num lang;
    num total;
    bool has_next;
    
    factory ArticleSearch.fromJson(Map<String,dynamic> json) => _$ArticleSearchFromJson(json);
    Map<String, dynamic> toJson() => _$ArticleSearchToJson(this);
}
