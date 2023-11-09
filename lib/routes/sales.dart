import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:maaya_tickets/components/success.dart';
import 'package:maaya_tickets/main.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final prnController = TextEditingController();
  final ticketIdController = TextEditingController();

  void showError(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  void scanPrn() async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ));
    setState(() {
      if (res is String) {
        prnController.text = res;
      }
    });
  }

  void submit() async {
    Response resp;
    dynamic dv;
    if (ticketIdController.text == "") {
      final uri = baseUri.replace(path: "/ticket");
      resp = await http.post(uri,
          body: jsonEncode({"token": token, "ticket_id": prnController.text}),
          headers: {"Content-Type": "application/json"});
      dv = jsonDecode(resp.body);
    } else {
      final uri = baseUri.replace(path: "/ticket/offline");
      resp = await http.post(uri,
          body: jsonEncode({
            "token": token,
            "ticket_id": prnController.text,
            "offline_id": ticketIdController.text
          }),
          headers: {"Content-Type": "application/json"});
      dv = jsonDecode(resp.body);
    }

    if (resp.statusCode != 200) {
      final err = dv["error"];
      showError(err);
    } else {
      showDialog(context: context, builder: (context) => SuccessComponent());
      prnController.clear();
      ticketIdController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concert Sales"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const SizedBox(),
            // const SizedBox(),
            TextFormField(
              controller: prnController,
              decoration: const InputDecoration(
                labelText: "Student PRN",
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
                controller: ticketIdController,
                decoration: const InputDecoration(
                  labelText: "Ticket ID",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      onPressed: scanPrn,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Scan Barcode",
                          style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                              wordSpacing: 1),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      onPressed: submit,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                              wordSpacing: 1),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
