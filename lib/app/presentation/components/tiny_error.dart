import 'package:flutter/material.dart';

class TinyError extends StatelessWidget {
  final VoidCallback? onTap;

  const TinyError({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Something went wrong.',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.refresh,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
