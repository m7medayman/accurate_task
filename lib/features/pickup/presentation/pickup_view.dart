import 'package:flutter/material.dart';

class PickupView extends StatelessWidget {
  const PickupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Create Pickup",
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Container(),
    );
  }
}
