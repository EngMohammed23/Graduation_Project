import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileDrawer extends StatelessWidget {
  ListTileDrawer({
    required this.title,
    required this.img,
    required this.nav,
    super.key,
  });
  String title;
  String img;
  Function () nav;

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: nav, leading: Image.asset(img),
      title: Text(title,style: GoogleFonts.cabin(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal),),
    );
  }
}

