import 'package:flutter/material.dart';

class CustomBackgroundTheme extends StatelessWidget {
  final Widget child;

  const CustomBackgroundTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6419BB),
            Color(0xFF3D0A8A),
          ],
        ),
      ),
      child: child, // This will display the passed child widget inside the gradient container
    );
  }
}
