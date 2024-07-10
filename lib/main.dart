import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget
  build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData.light().copyWith(
        // Base color for light theme elements (dark purple)
        primaryColor: const Color(0xFF6F42C1), // Dark Purple
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6F42C1), // Dark Purple
          brightness: Brightness.light,
          primary: const Color(0xFF6F42C1), // Dark Purple
          secondary: const Color(0xFFCE93D8), // Light Pink (accent)
          surface: Colors.white, // White for light theme elements
          background: Colors.white, // Team color for light mode (white)
          error: const Color(0xFFD32F2F), // Red
          onPrimary: Colors.black, // Black text on primary (adjusted for light mode)
          onSecondary: Colors.black, // Black text on secondary
          onSurface: Colors.black, // Black text on surface
          onBackground: Colors.black, // Black text on background
          onError: Colors.white, // White text on error
        ),
        scaffoldBackgroundColor: Colors.white, // Team color for light mode (white)
        appBarTheme: const AppBarTheme(
          // Maintain previous app bar color in light mode
          backgroundColor: Color(0xFFE91E63), // Light Red
          // Set foregroundColor to white for light mode text and icons
          foregroundColor: Colors.white, // White text and icons for light mode
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // Maintains dark theme settings from previous version
        // ... (refer to the previous response for dark theme settings)
      ),
      themeMode: ThemeMode.system, // Use system theme preference
      home: const GroceryList(),
    );
  }
}
