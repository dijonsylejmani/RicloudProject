import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/routes_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/live_track_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RiTravelApp());
}

class RiTravelApp extends StatelessWidget {
  const RiTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ri TRAVEL',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme().copyWith(
          displayLarge: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
          displayMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
          displaySmall: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.darkBlue),
          headlineMedium: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkBlue),
          bodyLarge: GoogleFonts.inter(fontSize: 16, color: AppColors.textDark),
          bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.textGrey),
          labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/routes': (context) => const LinjatScreen(),
        '/booking': (context) => const RezervoScreen(),
        '/about': (context) => const AboutScreen(),
        '/contact': (context) => const ContactScreen(),
        '/live_track': (context) => const LiveTrackScreen(),
      },
    );
  }
}