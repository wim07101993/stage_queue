import 'package:flutter/material.dart';

class MasterDetail extends StatelessWidget {
  const MasterDetail({
    super.key,
    required this.masterBuilder,
    required this.detailBuilder,
  });

  final WidgetBuilder masterBuilder;
  final WidgetBuilder detailBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: masterBuilder(context),
        ),
        Expanded(child: detailBuilder(context)),
      ],
    );
  }
}
