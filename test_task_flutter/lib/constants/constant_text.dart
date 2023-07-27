import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantText {
  static TextStyle appBarText = GoogleFonts.openSans(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400);
  static TextStyle categoryText = GoogleFonts.openSans(
      color: Colors.black,
      fontSize: 20,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300);
  static TextStyle featuredTitle = GoogleFonts.openSans(
      color: Colors.white,
      fontSize: 28,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300);
  static TextStyle titleText = GoogleFonts.openSans(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle greyText = GoogleFonts.openSans(
      color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400);
}
