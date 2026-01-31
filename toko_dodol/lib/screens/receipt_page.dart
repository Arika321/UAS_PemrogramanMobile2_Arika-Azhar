import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {
  final String name;
  final String address;
  final String payment;
  final int total;

  const ReceiptPage({
    super.key,
    required this.name,
    required this.address,
    required this.payment,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Struk Pembelian")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.receipt_long, size: 80),
            const SizedBox(height: 10),
            const Text(
              "TOKO DODOL ASGAR",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            buildRow("Nama", name),
            buildRow("Alamat", address),
            buildRow("Pembayaran", payment),
            buildRow("Total", "Rp $total"),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Pesanan Anda Sedang Diproses 🍬",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Kembali ke Home"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
