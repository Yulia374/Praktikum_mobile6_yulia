import 'package:flutter/material.dart';
import 'package:p6_katalogwisata/detailPage.dart';

 final List<Map<String, String>> travelData= [
      {
        'nama': 'Raja Ampat',
        'gambar': 'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'lokasi': 'Papua'
      },
      {
        'nama': 'Candi Borobudur',
        'gambar': 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'lokasi': 'Jawa Tengah'
      },
    ];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Katalog Wisata'),
          bottom: TabBar(
            indicatorSize: .label,
            tabs: [
              Tab(
                icon: Icon(Icons.view_agenda_outlined),
                text: 'List View',
              ),
              Tab(
                icon: Icon(Icons.grid_view),
                text: 'Grid View',
              ),
            ]
          ),
        ),

        body: TabBarView(
          children: [
            buildListView(),
            buildGridView()
          ]
        ),

      )
    );
  }
  Widget buildListView(){
    return ListView.builder(
      itemCount: travelData.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = travelData[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item['gambar']!,
                width: 80,
                height: 80,
                fit: .cover,
              ),
            ),
            title: Text(
              item['nama']!
            ),
            subtitle: Text(
              item['lokasi']!
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      gambar: item['gambar']!,
                      nama: item['nama']!,
                      lokasi: item['lokasi']!
                    ) ,
                  )
                );
              },
          ),
        );
      },
    );
  }

  Widget buildGridView(){
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: travelData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //mengatur kolom
        crossAxisSpacing: 16, //mengatur jarak horizontal
        mainAxisSpacing: 16, //mengatur jarak vertical
        childAspectRatio: 1
      ),
      itemBuilder: (context, index) {
        final item = travelData[index];

        return GestureDetector(
          // ===== TAMBAHAN: klik item grid -> halaman detail =====
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  gambar: item['gambar']!,
                  nama: item['nama']!,
                  lokasi: item['lokasi']!,
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10)
            ),
            clipBehavior: .antiAlias,

            child: Stack(
              fit: .expand,
              children: [
                Image.network(
                  item['gambar']!,
                  fit: .cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: .topCenter,
                      colors: [
                        const Color.fromRGBO(102, 91, 95, 1),
                        Colors.transparent
                      ]
                    )
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(item['nama']!,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(item['lokasi']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}