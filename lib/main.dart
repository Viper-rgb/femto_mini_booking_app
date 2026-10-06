import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/service_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServiceProvider()..fetchServices(),
        ),
      ],
      child: const FamtoBookingApp(),
    ),
  );
}

class FamtoBookingApp extends StatelessWidget {
  const FamtoBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famto Mini Service Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0F756D),
        scaffoldBackgroundColor: const Color(0xFFF8FAFB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F756D),
          primary: const Color(0xFF0F756D),
          secondary: const Color(0xFF00A896),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
