import 'package:flutter/material.dart';
import '../../domain/entities/hospital_model.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List<Hospital> hospitals = [
    Hospital(
      nama: 'Layanan Isolasi RS ABC',
      alamat: 'Jl. Kyai Maja No.43, Kebayoran Baru, Jakarta Selatan',
      jumlahPasien: 120,
      status: 'Penuh',
      contact: '021-7219000',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS DEF',
      alamat: 'Jl. Raya Serpong No.3, Tangerang Selatan',
      jumlahPasien: 90,
      status: 'Tersedia',
      contact: '021-5421000',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS GHI',
      alamat: 'Jl. Raya Bogor No.5, Bogor',
      jumlahPasien: 50,
      status: 'Tersedia',
      contact: '021-1234567',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS JKL',
      alamat: 'Jl. Raya Cibubur No.7, Depok',
      jumlahPasien: 70,
      status: 'Penuh',
      contact: '021-7654321',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS MNO',
      alamat: 'Jl. Raya Cileungsi No.9, Bogor',
      jumlahPasien: 30,
      status: 'Tersedia',
      contact: '021-9876543',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS PQR',
      alamat: 'Jl. Raya Cisarua No.11, Bogor',
      jumlahPasien: 40,
      status: 'Penuh',
      contact: '021-8765432',
    ),
    Hospital(
      nama: 'Layanan Isolasi RS STU',
      alamat: 'Jl. Raya Ciputat No.13, Tangerang Selatan',
      jumlahPasien: 60,
      status: 'Tersedia',
      contact: '021-6543210',
    ),
    // Tambahkan data rumah sakit lainnya di sini
  ];

  List<Hospital> filteredHospitals = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredHospitals = hospitals;
  }

  void _searchHospitals(String query) {
    List<Hospital> results = hospitals
        .where((hospital) =>
            hospital.nama.toLowerCase().contains(query.toLowerCase()) ||
            hospital.alamat.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredHospitals = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rumah Sakit'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama atau alamat...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _searchHospitals,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredHospitals.length,
        itemBuilder: (context, index) {
          final hospital = filteredHospitals[index];
          return ListTile(
            title: Text(hospital.nama),
            subtitle: Text(hospital.alamat),
            onTap: () => _showHospitalDetails(hospital),
          );
        },
      ),
    );
  }

  void _showHospitalDetails(Hospital hospital) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hospital.nama),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alamat: ${hospital.alamat}'),
              Text('Jumlah Pasien: ${hospital.jumlahPasien}'),
              Text('Status: ${hospital.status}'),
              Text('Kontak: ${hospital.contact}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
