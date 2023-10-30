import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/sales");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sell ticket",
                    style: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.w500, letterSpacing: -0.5, wordSpacing: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/validate");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Verify ticket",
                      style: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.w500, letterSpacing: -0.5, wordSpacing: 1),
                    ),
                  )),
              const SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}
