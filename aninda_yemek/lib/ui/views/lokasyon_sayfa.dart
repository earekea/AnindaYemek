import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasyonSayfa extends StatefulWidget {
  const LokasyonSayfa({super.key});

  @override
  State<LokasyonSayfa> createState() => _LokasyonSayfaState();
}

class _LokasyonSayfaState extends State<LokasyonSayfa> {
  Completer<GoogleMapController> haritaKontrol = Completer();

  //41.1134662,29.0328229,13.25z
  var baslangicKonum =
  CameraPosition(target: LatLng(41.1134662, 29.0328229), zoom: 13.25);
  List<Marker> isaretler = <Marker>[];

  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;

    //36.8980464,30.6357032,12z
    var gidilecekKonum =
    CameraPosition(target: LatLng(36.8980464, 30.6357032), zoom: 15);
    var gidilecekIsaret = Marker(
        markerId: MarkerId("id"),
        position: LatLng(36.8980464, 30.6357032),
        infoWindow: InfoWindow(title: "Antalya,", snippet: "Antalya Meydan")
    );

    setState(() {
      isaretler.add(gidilecekIsaret);

    });

    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton:Padding(
          padding: const EdgeInsets.only(right: 275,bottom: 20),
          child: FloatingActionButton(onPressed: (){
            konumaGit();
          },
          child: Icon(Icons.my_location_outlined,color: Color(0xff0d1b2a),),backgroundColor: Color(0xff8d99ae),),
        ),
      backgroundColor: Color(0xff8d99ae),


      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: baslangicKonum,
              mapType: MapType.normal,
              markers: Set<Marker>.of(isaretler),
              onMapCreated: (GoogleMapController controller) {
                haritaKontrol.complete(controller);
              },
            ),
          ),

        ],
      ),
    );
  }
}

