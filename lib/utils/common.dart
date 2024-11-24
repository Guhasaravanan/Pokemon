import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar successSnackbarMessage(String message) {
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      message,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    backgroundColor: Colors.teal,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
  );
}

SnackBar deleteSnackbarMessage(String message) {
  return SnackBar(
    duration: Duration(seconds: 1),
    content: Text(
      message,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    backgroundColor: Color.fromARGB(255, 236, 55, 31),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
  );
}
