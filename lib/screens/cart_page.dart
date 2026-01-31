import 'package:flutter/material.dart';
import '../services/product_service.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final service = ProductService();
  List cart = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  loadCart() async {
    cart = await service.getCart();
    setState(() {});
  }

  int get total {
    int sum = 0;
    for (var item in cart) {
      sum += (item['price'] as int) * (item['qty'] as int);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (_, i) {
                final item = cart[i];

                return ListTile(
                  leading: Image.asset(
                    item['image'],
                    width: 50,
                  ),
                  title: Text(item['name']),
                  subtitle: Text(
                    "Rp ${item['price']} x ${item['qty']}",
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: Rp $total",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutPage(total: total),
                        ),
                      );
                    },
                    child: const Text("Beli Sekarang"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
