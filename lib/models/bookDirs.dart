import 'package:json_annotation/json_annotation.dart';
import "bookGroup.dart";
part 'bookDirs.g.dart';

@JsonSerializable()
class BookDirs {
    BookDirs();

    bool success;
    List<BookGroup> items;
    
    factory BookDirs.fromJson(Map<String,dynamic> json) => _$BookDirsFromJson(json);
    Map<String, dynamic> toJson() => _$BookDirsToJson(this);
}
