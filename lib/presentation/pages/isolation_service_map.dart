import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class IsolationServiceMap extends StatefulWidget {
  @override
  _IsolationServiceMapState createState() => _IsolationServiceMapState();
}

class _IsolationServiceMapState extends State<IsolationServiceMap> {
  final List<Marker> _markers = [];
  LatLng _initialPosition =
      LatLng(-6.2088, 106.8456); // Default position di Jakarta

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _loadIsolationServices();
  }

  // Fungsi untuk mendapatkan lokasi pengguna
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Gagal mendapatkan lokasi pengguna: $e");
    }
  }

  // Fungsi untuk memuat data layanan isolasi dari Firestore
  Future<void> _loadIsolationServices() async {
    try {
      FirebaseFirestore.instance
          .collection('isolation_services')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          GeoPoint geoPoint = doc['location'];
          setState(() {
            _markers.add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(geoPoint.latitude, geoPoint.longitude),
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            );
          });
        });
      });
    } catch (e) {
      print("Gagal memuat data layanan isolasi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layanan Isolasi Mandiri'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _initialPosition,
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}
