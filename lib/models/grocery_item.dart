import 'package:hive/hive.dart';

part 'grocery_item.g.dart';

@HiveType(typeId: 0) // Unique ID for the model
class GroceryItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime expiryDate;

  GroceryItem({required this.name, required this.expiryDate});
}
