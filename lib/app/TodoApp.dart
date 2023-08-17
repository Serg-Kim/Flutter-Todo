import 'package:flutter/material.dart';

import '../presentation/screens/todoList/widgets/TodoList.dart';
import '../utils/constants/colors.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: COLORS.lightBlue),
        useMaterial3: true,
      ),
      home: const TodoList(),
    );
  }
}