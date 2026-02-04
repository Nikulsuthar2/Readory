import 'package:isar/isar.dart';

part 'annotation_model.g.dart';

@collection
class AnnotationModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String bookHash; // Foreign Key to BookModel (fileHash)

  late int pageNumber;

  late String content;

  String? selectedText;

  late String color;

  List<String> rects = []; // Serialized "x,y,w,h"

  late DateTime createdAt;
}
