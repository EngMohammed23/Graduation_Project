import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  GoogleMapController? _controller;
  final TextEditingController searchController = TextEditingController();
  String? _projectDuration = 'All Distance1'; // يجب أن تكون هذه واحدة من القيم الموجودة في القائمة


  final LatLng _initialPosition = LatLng(24.7136, 46.6753);  // الرياض
  final Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE4E4E4),
      appBar: AppBar(
        backgroundColor: Color(0XFFE4E4E4),
        leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
        title: Text('Filters',style: GoogleFonts.poppins(color:Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(child: Text('LOCATION',style: GoogleFonts.poppins(color:Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
            SizedBox(height: 15,),
            SizedBox(
              height: 200,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 14.0,
                ),
                markers: _markers,
                onTap: (LatLng position) {
                  setState(() {
                    _markers.add(
                      Marker(
                        markerId: MarkerId(position.toString()),
                        position: position,
                        infoWindow: InfoWindow(title: 'موقع جديد'),
                      ),
                    );
                  });
                },
              ),
            ),
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.location_on,color: Colors.white,),
                SizedBox(width: 16),
                Text('497 Evergreen Rd. Roseville, CA 95673',style: GoogleFonts.poppins(color:Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 19,),
            Center(child: Text('ADDITIONAL',style: GoogleFonts.poppins(color:Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
            SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddItionalWidget(text: 'DELIVERS', icon: Icons.delivery_dining,),
                AddItionalWidget(text: 'TRADES', icon: Icons.delivery_dining,),
                AddItionalWidget(text: 'DAY', icon: Icons.view_day,),
                AddItionalWidget(text: 'WEEK', icon: Icons.next_week,),
                AddItionalWidget(text: 'MONTH', icon: Icons.calendar_month,),

              ],
            ),
            SizedBox(height: 35,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: DropdownButtonFormField<String>(
                value: _projectDuration,  // تأكد من أن القيمة هنا واحدة من القيم في القائمة
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Color(0XFF003366)),
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 5
                  )
                ),
                items: [
                  'All Distance1',  // القيم يجب أن تكون فريدة
                  'All Distance2',
                  'All Distance3',
                  'All Distance4',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _projectDuration = value!;  // تحديث القيمة عند تغيير الاختيار
                  });
                },
              ),
            ),
            SizedBox(height: 48,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0XFF003366),
                      width: 2
                    )
                  ),
                  child: MaterialButton(
                    height: 48,
                    minWidth: 155,
                    color: Color(0XFFE4E4E4),
                    textColor: Color(0XFF003366),
                    onPressed: () {},
                    child: Text('RESET FILTERS',style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold),),),
                ),
                MaterialButton(
                  height: 48,
                  minWidth: 155,
                  color: Color(0XFF003366),
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text('APPLY FILTERS',style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold),),)
              ],
            )



          ],
        ),
      ),
    );
  }
}

class AddItionalWidget extends StatelessWidget {
  String text;
  IconData icon;
   AddItionalWidget({super.key,
     required this.text,
     required this.icon,
   });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1,color: Colors.white)
          ),
          child: Icon(icon,color: Color(0XFF003366),),
        ),
        SizedBox(height: 14,),
        Text(text,style: GoogleFonts.poppins(color:Color(0XFF003366),fontSize: 10,fontWeight: FontWeight.bold),),

      ],
    );
  }
}
