import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton(
      {super.key,
      required this.screenWidth,
      required this.icon,
      required this.content,
      this.onPressed});

  final double screenWidth;
  final IconData icon;
  final String content;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: screenWidth * 0.01,
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.white, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
