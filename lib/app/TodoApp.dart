import 'package:flutter/material.dart';

import '../navigation/RootNavigator.dart';

import '../utils/constants/colors.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: COLORS.lightBlue),
          useMaterial3: true,
        ),
        home: const RootNavigator(),
    );
  }
}
