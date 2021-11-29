import 'package:flutter/material.dart';

import '../../../core/core_packages.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;

  const LoadingIndicator({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30.0,
        height: 30.0,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? KColors.main,
          ),
        ),
      ),
    );
  }
}
