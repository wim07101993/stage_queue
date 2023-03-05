import 'package:flutter/material.dart';
import 'package:stage_queue/features/home/widgets/home_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StageQueue',
      home: HomeScreen(),
    );
  }
}
