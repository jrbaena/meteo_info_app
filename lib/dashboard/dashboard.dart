import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MeteoInfo"),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(),
          )
        ],
      ),
    );
  }
}
