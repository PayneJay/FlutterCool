import 'package:json_annotation/json_annotation.dart';

part 'bookChild.g.dart';

@JsonSerializable()
class BookChild {
    BookChild();

    String id;
    String link;
    String title;
    String thumb;
    String author;
    num price;
    num pubTime;
    
    factory BookChild.fromJson(Map<String,dynamic> json) => _$BookChildFromJson(json);
    Map<String, dynamic> toJson() => _$BookChildToJson(this);
}
