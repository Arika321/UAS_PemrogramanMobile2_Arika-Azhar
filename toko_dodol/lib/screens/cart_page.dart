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
  List cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  loadCart() async {
    cartItems = await service.getCart();
    setState(() {});
  }

  int get total {
    int t = 0;
    for (var item in cartItems) {
      t += (item['price'] * item['qty']) as int;
    }
    return t;
  }

  updateQty(int id, int qty) async {
    if (qty < 1) return;
    await service.updateQty(id, qty);
    loadCart();
  }

  deleteItem(int id) async {
    await service.deleteCart(id);
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, i) {
                final item = cartItems[i];

                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 55,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rp ${item['price']}"),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                updateQty(item['id'], item['qty'] - 1);
                              },
                            ),
                            Text("${item['qty']}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                updateQty(item['id'], item['qty'] + 1);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteItem(item['id']);
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // TOTAL & CHECKOUT
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total : Rp $total",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                    child: const Text("Checkout"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
