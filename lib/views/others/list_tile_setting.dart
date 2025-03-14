import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ListTileSetting extends StatelessWidget {
  ListTileSetting({
     required this.title,
    required this.icon,
     required this.nav,
    super.key,
  });
  String title;
  Icon icon ;
  Function () nav;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: ListTile(
        onTap: () {
          nav;
        },
        title: Text(title,style: GoogleFonts.inter(fontSize: 15,),),
        leading: icon,
        trailing: IconButton(icon: Icon(Icons.navigate_next),onPressed: nav,),
      ),
    );
  }
}