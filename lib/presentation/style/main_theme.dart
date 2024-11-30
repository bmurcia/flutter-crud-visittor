import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buidlMainTheme(BuildContext context){
  return ThemeData(
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
      highlightColor: Colors.deepPurple,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
  );
}