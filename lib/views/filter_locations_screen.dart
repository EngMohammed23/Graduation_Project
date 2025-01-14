import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FilterLocationsScreen extends StatefulWidget {
  const FilterLocationsScreen({super.key});

  @override
  State<FilterLocationsScreen> createState() => _FilterLocationsScreenState();
}

class _FilterLocationsScreenState extends State<FilterLocationsScreen> {
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? _controller;


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
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
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
          SafeArea(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.arrow_back,color:Color(0XFF003366) ,)),
                SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: '3rd Avenue 43',
                    ),
                  ),
                ),
              ],
            ),
          )),

        ],
      ),
    );
  }
}
