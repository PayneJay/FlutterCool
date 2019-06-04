import 'package:json_annotation/json_annotation.dart';
import "site.dart";
part 'siteSearch.g.dart';

@JsonSerializable()
class SiteSearch {
    SiteSearch();

    bool success;
    List<Site> items;
    
    factory SiteSearch.fromJson(Map<String,dynamic> json) => _$SiteSearchFromJson(json);
    Map<String, dynamic> toJson() => _$SiteSearchToJson(this);
}
