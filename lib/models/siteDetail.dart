import 'package:json_annotation/json_annotation.dart';
import "articles.dart";
import "site.dart";
part 'siteDetail.g.dart';

@JsonSerializable()
class SiteDetail {
    SiteDetail();

    bool success;
    List<Articles> articles;
    Site site;
    bool has_next;
    
    factory SiteDetail.fromJson(Map<String,dynamic> json) => _$SiteDetailFromJson(json);
    Map<String, dynamic> toJson() => _$SiteDetailToJson(this);
}
