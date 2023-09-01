import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/state/Counter.dart';

class CounterSubScreen extends ConsumerWidget {
  const CounterSubScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
        appBar: AppBar(title: Text("Second Screen. Clicks: $count")),
        body: Center(
            child: ElevatedButton(
              child: const Text('Go to Other'),
              onPressed: () => print('asd'),
            )
        ),
        floatingActionButton:
        FloatingActionButton(child: const Icon(Icons.add), onPressed: () => ref.read(counterProvider.notifier).increment())
    );
  }
}
