import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final service = ProductService();
  int qty = 1; // ✅ jumlah beli

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Image.asset(
              widget.product.image,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 12),

            // NAME
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // PRICE
            Text("Rp ${widget.product.price}"),

            const SizedBox(height: 10),

            // QTY CONTROL
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (qty > 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  qty.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const Spacer(),

            // ADD TO CART
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await service.addToCart(widget.product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Masuk keranjang"),
                    ),
                  );
                },
                child: const Text("Tambah ke Keranjang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
