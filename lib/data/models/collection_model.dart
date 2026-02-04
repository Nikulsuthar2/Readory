import 'package:isar/isar.dart';

part 'collection_model.g.dart';

@collection
class CollectionModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String name;
  
  bool isDefault = false;
  
  // We can verify if we want to link books here or keep it decoupled via string IDs.
  // Decoupling via String name in BookModel.collections is easier for now avoiding Links.
}
