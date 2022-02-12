import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme(BuildContext context) => ThemeData(
      primaryColor: const Color.fromRGBO(235, 87, 87, 1),
      colorScheme: Theme.of(context).colorScheme.copyWith(
            secondary: const Color.fromRGBO(235, 87, 87, 1),
          ),
      scaffoldBackgroundColor: Colors.grey.shade100,
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(
          fontSize: 20,
          color: const Color.fromRGBO(79, 79, 79, 1),
          fontWeight: FontWeight.w700,
        ),
        bodyText1: GoogleFonts.montserrat(
          fontSize: 15,
          color: const Color.fromRGBO(79, 79, 79, 1),
        ),
        bodyText2: GoogleFonts.montserrat(
          fontSize: 15,
          color: const Color.fromRGBO(130, 130, 130, 1),
        ),
      ),
      buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(235, 87, 87, 1),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
    );
