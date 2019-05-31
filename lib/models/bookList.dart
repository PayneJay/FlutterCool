import 'package:json_annotation/json_annotation.dart';
import "bookChild.dart";
part 'bookList.g.dart';

@JsonSerializable()
class BookList {
    BookList();

    bool success;
    List<BookChild> items;
    bool has_next;
    
    factory BookList.fromJson(Map<String,dynamic> json) => _$BookListFromJson(json);
    Map<String, dynamic> toJson() => _$BookListToJson(this);
}
