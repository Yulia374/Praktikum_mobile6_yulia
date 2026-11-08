import 'package:flutter/material.dart';
import 'package:list_makanan/detailPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> makanan = const [
      {
        'nama': 'Nasi Goreng Spesial',
        'harga': 25000,
        'deskripsi': 'Nasi goreng bumbu rempah dengan telur, ayam suwir, acar, dan kerupuk.',
        'gambar': 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=60'
      },
      {
        'nama': 'Sate Ayam',
        'harga': 30000,
        'deskripsi': 'Sate ayam bakar dengan bumbu kacang kental dan lontong hangat.',
        'gambar': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=60'
      },
      {
        'nama': 'Beef Burger',
        'harga': 45000,
        'deskripsi': 'Burger daging sapi juicy dengan keju, selada, tomat, dan saus spesial.',
        'gambar': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800&q=60'
      },
      {
        'nama': 'Pizza Margherita',
        'harga': 60000,
        'deskripsi': 'Pizza klasik dengan saus tomat, mozzarella, dan daun basil segar.',
        'gambar': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=60'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        leading: const Icon(Icons.restaurant_menu),
        title: const Text('Daftar Makanan'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 125, 168),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: makanan.length,
        itemBuilder: (context, index) {
          final item = makanan[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(bottom: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      nama: item['nama'],
                      harga: item['harga'],
                      deskripsi: item['deskripsi'],
                      gambar: item['gambar'],
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(
                    item['gambar'],
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(item['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(rupiah(item['harga']),
                        style: const TextStyle(color: Colors.pinkAccent)),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}