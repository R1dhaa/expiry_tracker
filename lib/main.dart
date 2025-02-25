import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/grocery_item.dart';
import 'screens/grocery_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GroceryItemAdapter()); // Register model
  await Hive.openBox<GroceryItem>('groceryBox'); // Open storage box
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroceryListScreen(),
    );
  }
}
