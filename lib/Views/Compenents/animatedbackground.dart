import 'package:flutter/material.dart';
import 'package:lit_starfield/view/lit_starfield_container.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitStarfieldContainer(
      animated: true,
      number: 500,
      velocity: 0.85,
      depth: 0.9,
      scale: 4,
      starColor: Colors.purple,
      backgroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 9, 20),
            Color.fromARGB(255, 105, 1, 109),
            Color.fromARGB(255, 255, 255, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
