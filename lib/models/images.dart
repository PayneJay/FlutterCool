import 'package:json_annotation/json_annotation.dart';

part 'images.g.dart';

@JsonSerializable()
class Images {
    Images();

    String id;
    num w;
    num h;
    String src;
    
    factory Images.fromJson(Map<String,dynamic> json) => _$ImagesFromJson(json);
    Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
