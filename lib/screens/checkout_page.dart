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

  String payment = "COD";

  checkout() async {
    await service.checkoutOrder(
      name.text,
      address.text,
      payment,
      widget.total,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptPage(
          name: name.text,
          address: address.text,
          payment: payment,
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
              decoration: const InputDecoration(labelText: "Nama Lengkap"),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(labelText: "Alamat"),
            ),
            DropdownButtonFormField(
              value: payment,
              items: const [
                DropdownMenuItem(value: "COD", child: Text("COD")),
                DropdownMenuItem(value: "Dana", child: Text("Dana")),
                DropdownMenuItem(
                    value: "Transfer Bank", child: Text("Transfer Bank")),
              ],
              onChanged: (v) {
                setState(() {
                  payment = v.toString();
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
