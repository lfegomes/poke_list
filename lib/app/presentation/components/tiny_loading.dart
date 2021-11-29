import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class TinyLoading extends StatelessWidget {
  const TinyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: LoadingIndicator(),
    );
  }
}
