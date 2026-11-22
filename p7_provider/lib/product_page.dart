import 'package:flutter/material.dart';
import 'package:p7_provider/cart_model.dart';
import 'package:p7_provider/cart_page.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final products = [
    Product('Keyboard', 'Perangkat untuk mengetik',
        'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=300&q=60'),
    Product('Mouse', 'Perangkat untuk menggerakan pointer',
        'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=300&q=60'),
    Product('Monitor', 'Perangkat untuk menampilkan gambar',
        'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=300&q=60')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Elektronik'),
        backgroundColor: const Color.fromARGB(255, 51, 0, 17),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),

            child: Consumer<CartModel>(
              builder: (context, cart, child){
                return Badge(
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        )
                      );
                    },
                    icon: Icon(Icons.shopping_cart)
                  ),
                );
              },
            )
          )
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: const Color.fromARGB(255, 66, 23, 37),
                backgroundImage: NetworkImage(product.gambar),
              ),
              title: Text(product.nama),
              subtitle: Text(product.deskripsi),
              trailing: IconButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).add(product);
                },
                icon: Icon(Icons.add_shopping_cart, color: const Color.fromARGB(255, 80, 29, 46),)
              ),
            ),
          );
        },
      ),
    );
  }
}
