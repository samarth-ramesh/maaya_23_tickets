import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessComponent extends StatelessWidget {
  const SuccessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Success",
        style: GoogleFonts.oswald(fontSize: 38),
        textAlign: TextAlign.center,
      ),
      content: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 48,
      ),
       actions: [
         ElevatedButton(onPressed: (){
           Navigator.of(context).pop();
         }, child: Text("Close"))
       ],
    );
  }
}
