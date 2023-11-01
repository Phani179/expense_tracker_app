import 'package:expense_tracker_app/screens/expenses_screen.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 33, 199, 192),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: kDarkColorScheme.secondaryContainer,
      ),
      iconTheme: IconThemeData().copyWith(
        color: kDarkColorScheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
      ),
    ),
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.primary,
        foregroundColor: kColorScheme.background,
      ),
      cardTheme: const CardTheme().copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: kColorScheme.secondaryContainer,
      ),
      textTheme: ThemeData().textTheme.copyWith(
            bodyMedium: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            titleLarge: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.primary,
        ),
      ),
    ),
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
    home: const ExpensesScreen(),
  ));
}
