import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/grocery_item.dart';
import 'screens/add_grocery_screen.dart';
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
       theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
    ),
    home: GroceryListScreen(),
    routes: {
      "/add-grocery": (context) => AddGroceryScreen()
    },
    );
}
}
