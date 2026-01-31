import 'package:flutter/material.dart';
import '../services/product_service.dart';
import 'receipt_page.dart';

class CheckoutPage extends StatefulWidget {
  final int total;

  const CheckoutPage({super.key, required this.total});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final service = ProductService();

  final name = TextEditingController();
  final address = TextEditingController();

  String paymentMethod = "COD";

  checkout() async {
    await service.checkoutOrder(
      name.text,
      address.text,
      paymentMethod,
      widget.total,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptPage(
          name: name.text,
          address: address.text,
          payment: paymentMethod,
          total: widget.total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Nama Pemesan",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                labelText: "Alamat Pengiriman",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: paymentMethod,
              items: const [
                DropdownMenuItem(value: "COD", child: Text("COD")),
                DropdownMenuItem(value: "DANA", child: Text("DANA")),
                DropdownMenuItem(value: "OVO", child: Text("OVO")),
                DropdownMenuItem(value: "BANK", child: Text("Transfer Bank")),
              ],
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
              decoration: const InputDecoration(
                labelText: "Metode Pembayaran",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Total Bayar : Rp ${widget.total}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: checkout,
                child: const Text("Buat Pesanan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
