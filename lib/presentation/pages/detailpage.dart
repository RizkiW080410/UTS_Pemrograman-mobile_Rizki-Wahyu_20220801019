import 'package:flutter/material.dart';
import 'package:uts_pemmob/models/wisata_model.dart';

class DetailPage extends StatelessWidget {
  final Wisata wisata;

  DetailPage({required this.wisata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wisata.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar dengan Rounded Corners
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  wisata.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              // Nama Wisata
              Text(
                wisata.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Divider(thickness: 1.5, height: 24),
              // Alamat
              Row(
                children: [
                  Icon(Icons.place, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      wisata.address,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Deskripsi
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      wisata.description,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
