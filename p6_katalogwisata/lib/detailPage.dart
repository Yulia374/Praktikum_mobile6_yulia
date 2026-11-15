import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final String gambar, nama, lokasi;

  const DetailPage({
    super.key,
    required this.gambar,
    required this.nama,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
        backgroundColor: const Color.fromARGB(255, 255, 125, 168),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                ClipRRect(
                  borderRadius: .circular(10),
                    child: Image.network(
                      gambar,
                      width: double.infinity,
                      height: 250,
                      fit: .cover,
                    ),
                ),
                SizedBox(height: 10,),
                Text(nama),
                Divider(height: 30, color: Colors.pinkAccent,),
                SizedBox(height: 20,),
                Text(lokasi)
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}