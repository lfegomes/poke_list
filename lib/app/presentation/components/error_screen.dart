import 'package:flutter/material.dart';

import '../../../core/core_packages.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
    this.onTryAgain, {
    Key? key,
  }) : super(key: key);

  final Function() onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Something went wrong. Please, try again.",
              // style: KTextStyle.body1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50,
              width: 608.0,
              child: TextButton(
                onPressed: onTryAgain,
                child: const Text("Try again"),
                style: TextButton.styleFrom(
                  primary: KColors.main,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
