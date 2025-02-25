import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/grocery_item.dart';

class AddGroceryScreen extends StatefulWidget {
  const AddGroceryScreen({super.key});

  @override
  _AddGroceryScreenState createState() => _AddGroceryScreenState();
}

class _AddGroceryScreenState extends State<AddGroceryScreen> {
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void saveGroceryItem() {
    final box = Hive.box('groceryBox');
    final newItem = GroceryItem(name: nameController.text, expiryDate: selectedDate);
    box.add(newItem);
    Navigator.pop(context);
  }

  void pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Grocery")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Grocery Name"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expiry Date: ${selectedDate.toLocal()}"),
                TextButton(
                  onPressed: pickDate,
                  child: Text("Pick Date"),
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveGroceryItem,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
