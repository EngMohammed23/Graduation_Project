import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  State<PaymentManagementScreen> createState() => _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
        title: Text('Payment Management',style: GoogleFonts.poppins(color: Color(0XFF003366),fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor:Color(0XFF707070) ,
                child: Icon(Icons.person,color: Colors.white,)
               ),
              title: Text('Product',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
              trailing: Text('+24,89',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
            ),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor:Color(0XFF707070) ,
                child: Icon(Icons.person,color: Colors.white,)
               ),
              title: Text('Product',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
              trailing: Text('+24,89',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
            ),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 20,
                backgroundColor:Color(0XFF707070) ,
                child: Icon(Icons.person,color: Colors.white,)
               ),
              title: Text('Product',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
              trailing: Text('+24,89',style: GoogleFonts.inter(fontSize: 15,color: Color(0XFF003366)),),
            ),
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF003366),width: 1),
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                title: Text('Send Payment',style: GoogleFonts.poppins(fontSize: 15,color: Color(0XFF003366)),),
                trailing: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 6,horizontal: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFF003366),
                      border: Border.all(color: Color(0XFF003366),width: 1),
                      borderRadius: BorderRadius.circular(15)
                  ),
                    child: Text('523',style: GoogleFonts.poppins(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF003366),width: 1),
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                title: Text('Send Payment',style: GoogleFonts.poppins(fontSize: 15,color: Color(0XFF003366)),),
                trailing: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 6,horizontal: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFF003366),
                      border: Border.all(color: Color(0XFF003366),width: 1),
                      borderRadius: BorderRadius.circular(15)
                  ),
                    child: Text('523',style: GoogleFonts.poppins(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0XFF003366),width: 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                title: Text('Send Payment',style: GoogleFonts.poppins(fontSize: 15,color: Color(0XFF003366)),),
                trailing: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 6,horizontal: 30),
                    decoration: BoxDecoration(
                        color: Color(0XFF003366),
                        border: Border.all(color: Color(0XFF003366),width: 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text('523',style: GoogleFonts.poppins(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                color: Color(0XFF003366).withOpacity(0.6),
                  border: Border.all(color: Color(0XFF003366),width: 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                title: Text('Total Payments',style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),
                trailing: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 6,horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.white ,
                        border: Border.all(color: Colors.white,width: 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text('10254',style: GoogleFonts.poppins(fontSize: 15,color: Color(0XFF003366),fontWeight: FontWeight.bold),)),
              ),
            ),







          ],
        ),
      ),
    );
  }
}
