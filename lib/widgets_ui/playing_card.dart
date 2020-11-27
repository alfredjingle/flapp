import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayingCard extends StatelessWidget {
  final String imagePath;

  PlayingCard(this.imagePath);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            height: screenSize.height * 0.7,
            width: screenSize.width * 0.8,
            child: Image.asset(imagePath, fit: BoxFit.cover)),
      ),
    );
  }
}
