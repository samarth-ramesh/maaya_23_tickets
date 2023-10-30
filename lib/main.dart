import 'package:flutter/material.dart';
import 'package:maaya_tickets/routes/dashboard.dart';
import 'package:maaya_tickets/routes/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maaya_tickets/routes/sales.dart';
import 'package:maaya_tickets/routes/validate.dart';

var baseUri = Uri.https("backend.samarthr.gq", "");

void main() {
  runApp(const Main());
}

var token = "";

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          // ···
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        "/dashboard": (context) => const Dashboard(),
        "/sales": (context) => const Sales(),
        "/validate": (context) => const Validate(),
      },
      initialRoute: '/',
      // home: LoginScreen(),
    );
  }
}
