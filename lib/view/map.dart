import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utilits.dart';
import 'dart:ui' as ui;

import 'package:untitled/view/single_user.dart';
class MapScreen extends StatefulWidget {
  final double lat;
  final double long;
  final String id;
  final String name;
  const MapScreen({Key? key, required this.lat, required this.long, required this.id, required this.name}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();


  Future<Uint8List> getMarkeeIcon(String path, int width)async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData())!.buffer.asUint8List();
  }
  List<Marker> marker = <Marker> [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    print(marker.length);
  }
 Future load()async{ 
    print("object");
    final Uint8List markerIcon = await getMarkeeIcon("assets/images/flash_bg.png", 100);

    print("markerIcon $markerIcon");
   for(var i = 0 ; i < 2 ; i ++){
     print(i);
     marker.add(
       Marker(
         markerId: MarkerId("50"),
         position: LatLng(23.727106, 90.3842538),
         icon:  BitmapDescriptor.defaultMarker,
         infoWindow: InfoWindow(
           title: "${widget.name}",
           snippet: "See Profile",
           onTap: ()=>Get.to(SingleUser(id: widget.id))
         )
       ),
     );
     setState(() {

     });
   }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color:AppUtilits.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          size: 30,//change size on your need
          color: Colors.black45,//change color on your need
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(23.7271066,90.3842538),
          zoom: 14.4746,
        ),
        markers: Set<Marker>.of(marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  getBytesFromAsset({required String path, required int width}) {}
}
