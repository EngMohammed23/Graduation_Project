import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  double _rating = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_outlined)),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.share)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/three.jpg'),
            SizedBox(height: 9,),
            SizedBox(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nov 4 - 5 min read',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black54),),
                    SizedBox(height: 3,),
                    Text('Well, well, well, how the turntables',style: GoogleFonts.poppins(fontSize: 20,color: Colors.black)),
                    SizedBox(height: 3,),
                    Text("Wikipedia is the best thing ever. Anyone in the world can write anything they want about any subject. So you know you are getting the best possible information."
                        "\n And I knew exactly what to do. But in a much more real sense, I had no idea what to do.Okay, too many different words from coming at me from too many different sentences."
                        "\n Wikipedia is the best thing ever. Anyone in the world can write anything they want about any subject. So you know you are getting the best possible information.",
                      style: GoogleFonts.poppins(fontSize: 18,color: Colors.black,),),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment:  MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                MaterialButton(
                    height: 56,
                    minWidth: 148,
                    color: Color(0XFF003366),
                    textColor: Colors.white,
                    child: Text('Edit'),
                    onPressed: () {

                    }),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Expected Delivery Date',style: GoogleFonts.poppins(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    Text('Completion Rate',style: GoogleFonts.poppins(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true, // السماح بتقييم نصف النجمة
                      itemCount: 5, // عدد النجوم
                      itemSize: 30.0, // حجم النجمة
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Color(0XFF003366),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('15-10-2024',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    Text('%50',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
                    ]),
                  ],
            )
          ],
        ),
      ),
    );
  }
}
