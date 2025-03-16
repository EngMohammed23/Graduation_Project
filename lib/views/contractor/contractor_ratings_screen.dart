import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takatuf/controller/contractor/contractor_ratings_controller.dart';


class ContractorRatingsScreen extends StatelessWidget {
  const ContractorRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام GetX للتحكم في الController
    final ContractorRatingsController controller = Get.put(ContractorRatingsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF003366),
        centerTitle: true,
        title: Text(
          'contractorRatings'.tr(),
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 220,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 50, vertical: 30),
            decoration: BoxDecoration(
              color: Color(0XFF003366),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/three.jpg",
                        width: 105,
                        height: 105,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "contractorName".tr(),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 8),
                    Obx(() => RatingBar.builder(
                      initialRating: controller.rating.value,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true, // السماح بتقييم نصف النجمة
                      itemCount: 5,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        controller.updateRating(rating);
                      },
                    )),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "userReviewMessage".tr(),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              itemCount: controller.contractors.length,
              itemBuilder: (context, index) {
                final contractor = controller.contractors[index];

                return Card(
                  color: Colors.white,
                  margin: EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: ListTile(
                    minTileHeight: 80,
                    leading: ClipOval(
                      child: Image.asset(
                        contractor.image!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      contractor.title!,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black),
                    ),
                    trailing: RatingBar.builder(
                      initialRating: contractor.rating!,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Color(0XFF003366),
                      ),
                      onRatingUpdate: (rating) {
                        controller.updateRating(rating);
                      },
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
