import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/grocery_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final Box<GroceryItem> groceryBox = Hive.box<GroceryItem>('groceryBox');

  void _addGroceryItem() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: Text("Add Grocery Item"),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter item name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  groceryBox.add(GroceryItem(
                    name: name,
                    expiryDate: DateTime.now().add(Duration(days: 7)), // Example expiry date
                  ));
                  setState(() {}); // Refresh UI
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery List")),
      body: ValueListenableBuilder(
        valueListenable: groceryBox.listenable(),
        builder: (context, Box<GroceryItem> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No items added yet."));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              GroceryItem item = box.getAt(index)!;
              return ListTile(
                title: Text(item.name),
                subtitle: Text("Expires on: ${item.expiryDate.toLocal()}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    box.deleteAt(index);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGroceryItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
