import 'package:equatable/equatable.dart';

class CollectionEntity extends Equatable {
  final String id;
  final String name;
  final bool isDefault; // e.g. "Favorites"

  const CollectionEntity({
    required this.id,
    required this.name,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, name, isDefault];
}
