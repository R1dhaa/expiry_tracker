import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/grocery_item.dart';
import 'add_grocery_screen.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late Box<GroceryItem> groceryBox;

  @override
  void initState() {
    super.initState();
    groceryBox = Hive.box<GroceryItem>('groceryBox');
  }

  void _deleteItem(int index) {
    groceryBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grocery List")),
      body: ValueListenableBuilder(
        valueListenable: groceryBox.listenable(),
        builder: (context, Box<GroceryItem> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No items added yet."));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index)!;
              return ListTile(
                title: Text(item.name),
                subtitle: Text("Expiry: ${item.expiryDate.toLocal()}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteItem(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddGroceryScreen()),
        ),
      ),
    );
  }
}
