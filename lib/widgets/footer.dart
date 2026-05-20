import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B1221),
      padding: const EdgeInsets.all(48),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // On small screens, use Column
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildColumn(
                  'Rreth nesh',
                  ['Ri Travel ofron shërbime cilësore', 'për udhëtarët në gjithë Kosovën'],
                ),
                const SizedBox(height: 32),
                _buildColumn(
                  'Linjat e shpejta',
                  ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë'],
                ),
                const SizedBox(height: 32),
                _buildColumn(
                  'Shërbimet tona',
                  ['Booking Online', 'Live Tracking', 'Support 24/7'],
                ),
                const SizedBox(height: 32),
                _buildColumn(
                  'Kontakt',
                  ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë'],
                ),
              ],
            );
          } else {
            // On larger screens, use Row
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildColumn(
                  'Rreth nesh',
                  ['Ri Travel ofron shërbime cilësore', 'për udhëtarët në gjithë Kosovën'],
                ),
                _buildColumn(
                  'Linjat e shpejta',
                  ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë'],
                ),
                _buildColumn(
                  'Shërbimet tona',
                  ['Booking Online', 'Live Tracking', 'Support 24/7'],
                ),
                _buildColumn(
                  'Kontakt',
                  ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë'],
                ),
              ],
            );
          }
        },
      ),
    );
  }
  
  Widget _buildColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            item,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        )),
      ],
    );
  }
}