import 'package:Dictionary/widgets/colors/grey_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleTextStyle() =>
    TextStyle(fontFamily: 'Futura', fontSize: 35, color: greyColor());

TextStyle plainTextStyle() =>
    GoogleFonts.roboto(fontSize: 15, color: greyColor());
