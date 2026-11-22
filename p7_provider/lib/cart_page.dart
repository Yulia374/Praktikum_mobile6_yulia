import 'package:flutter/material.dart';
import 'package:p7_provider/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Anda'),
        backgroundColor: const Color.fromARGB(255, 51, 0, 17),
        foregroundColor: Colors.white,
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if(cart.items.isEmpty){
            return Center(
              child: Text('Keranjang KOSONG!'),
            );
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final product = cart.items[index];
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
                    Provider.of<CartModel>(context, listen: false).remove(product);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Hapus',
                ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}