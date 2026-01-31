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
      appBar: AppBar(title: const Text("Bukti Pembelian")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.receipt, size: 80),
            Text("Nama: $name"),
            Text("Alamat: $address"),
            Text("Pembayaran: $payment"),
            Text("Total: Rp $total"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Text("Kembali ke Home"),
            )
          ],
        ),
      ),
    );
  }
}
