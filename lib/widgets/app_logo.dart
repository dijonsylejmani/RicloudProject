import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  
  const AppLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFE5A335),
            borderRadius: BorderRadius.circular(size * 0.25),
          ),
          child: Icon(
            Icons.directions_bus,
            color: const Color(0xFF0B1221),
            size: size * 0.6,
          ),
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ri ',
                style: TextStyle(
                  fontSize: size * 0.5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF0B1221),
                ),
              ),
              TextSpan(
                text: 'TRAVEL',
                style: TextStyle(
                  fontSize: size * 0.45,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: const Color(0xFFE5A335),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}