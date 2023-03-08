import 'package:flutter/material.dart';

class MultiListenableBuilder extends StatefulWidget {
  const MultiListenableBuilder({
    super.key,
    required this.listenables,
    required this.builder,
  });

  final List<Listenable> listenables;
  final WidgetBuilder builder;

  @override
  State<MultiListenableBuilder> createState() => _MultiListenableBuilderState();
}

class _MultiListenableBuilderState extends State<MultiListenableBuilder> {
  @override
  void initState() {
    super.initState();
    for (final listenable in widget.listenables) {
      listenable.addListener(onChanged);
    }
  }

  @override
  void didUpdateWidget(covariant MultiListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenables != widget.listenables) {
      for (final listenable in oldWidget.listenables) {
        listenable.removeListener(onChanged);
      }
      for (final listenable in widget.listenables) {
        listenable.addListener(onChanged);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final listenable in widget.listenables) {
      listenable.removeListener(onChanged);
    }
  }

  void onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
