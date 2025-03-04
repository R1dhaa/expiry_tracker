import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/grocery_item.dart';

class AddGroceryScreen extends StatefulWidget {
  const AddGroceryScreen({super.key});

  @override
  State<AddGroceryScreen> createState() => _AddGroceryScreenState();
}

class _AddGroceryScreenState extends State<AddGroceryScreen> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now(); // NEW TIME FIELD
  late Box<GroceryItem> groceryBox;

  @override
  void initState() {
    super.initState();
    groceryBox = Hive.box<GroceryItem>('groceryBox');
  }

void _addItem() {
  if (_nameController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item name cannot be empty!")),
    );
    return;
  }

  String formattedTime = _selectedTime.format(context);
  final newItem = GroceryItem(
    name: _nameController.text.trim(),
    expiryDate: _selectedDate,
  );

  groceryBox.add(newItem);
  Navigator.pop(context);
}

  void _pickDate(BuildContext context) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (picked != null) {  // ✅ Prevent assigning null
    setState(() {
      _selectedDate = picked;
    });
  }
}


  void _pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Grocery Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Item Name"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expiry Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  child: const Text("Pick Date"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expiry Time: ${_selectedTime.format(context)}"),
                ElevatedButton(
                  onPressed: () => _pickTime(context),
                  child: const Text("Pick Time"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
