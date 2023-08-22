import 'package:flutter/material.dart';
import 'package:mmkv/mmkv.dart';

import 'app/TodoApp.dart';

void main() async {
  await MMKV.initialize();
  runApp(const TodoApp());
}
