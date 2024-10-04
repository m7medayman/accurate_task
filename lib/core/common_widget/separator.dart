import 'package:flutter/material.dart';

class FormSeparator extends StatelessWidget {
  FormSeparator({
    this.percent = 0.02,
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;
  double? percent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: percent! * screenHeight,
    );
  }
}

class SmallFormSeparator extends StatelessWidget {
  SmallFormSeparator({
    this.percent = 0.01,
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;
  double? percent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: percent! * screenHeight,
    );
  }
}

class BigFormSeparator extends StatelessWidget {
  final double screenHeight;
  const BigFormSeparator({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15,
    );
  }
}
