import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  const ConnectionLostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/network.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            left: 60,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 25,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.17),
                  ),
                ],
              ),
              child: FilledButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Retry',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
