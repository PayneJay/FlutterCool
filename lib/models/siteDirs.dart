import 'package:json_annotation/json_annotation.dart';
import "siteGroup.dart";
part 'siteDirs.g.dart';

@JsonSerializable()
class SiteDirs {
    SiteDirs();

    bool success;
    List<SiteGroup> items;
    
    factory SiteDirs.fromJson(Map<String,dynamic> json) => _$SiteDirsFromJson(json);
    Map<String, dynamic> toJson() => _$SiteDirsToJson(this);
}
