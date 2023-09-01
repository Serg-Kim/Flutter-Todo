import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/state/Counter.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
        appBar: AppBar(title: Text("First Screen. Clicks: $count")),
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

class Other extends ConsumerWidget {
  const Other({super.key});

  @override
  Widget build(context, WidgetRef ref){
    final count = ref.watch(counterProvider);

    return Scaffold(body: Center(child: Text("$count")));
  }
}