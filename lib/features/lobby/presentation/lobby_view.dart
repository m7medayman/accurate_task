import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:flutter/material.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Lobby",
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
            ),
            Divider(),
            Container(
              width: screenWidth * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.createPickup);
                      },
                      child: Text("create PickUp"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
