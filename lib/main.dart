import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_web_app/view/about/screens/about_screen.dart';
import 'package:my_web_app/view/contact/screens/contact_screen.dart';
import 'package:my_web_app/view/home/screens/home_screen.dart';
import 'package:my_web_app/view/projects/screens/projects_screen.dart';
import 'package:my_web_app/view/services/screens/services_screen.dart';
import 'package:my_web_app/view/testimonials/screens/testimonials_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdallah Hammad Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(
          ThemeData.light().textTheme.copyWith(
                headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                bodyLarge: const TextStyle(fontSize: 18),
              ),
        ),
      ),
      // إعدادات RTL
      locale: const Locale('ar'), // اللغة العربية
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/services': (context) => const ServicesScreen(),
        '/testimonials': (context) => const TestimonialsScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}