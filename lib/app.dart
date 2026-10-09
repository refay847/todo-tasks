import 'package:flutter/material.dart';
import 'features/tasks/presentation/tasks_page.dart';

class TaskCounterApp extends StatelessWidget {
  const TaskCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B5CE2);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Tasks',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: const Color(0xFFF8F9FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FC),
        fontFamily: 'sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FC),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF4F5F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: seed, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
      ),
      home: const TasksPage(),
    );
  }
}
