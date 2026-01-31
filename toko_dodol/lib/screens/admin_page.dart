import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List orders = [];

  loadOrders() async {
    orders = await Supabase.instance.client
        .from('orders')
        .select()
        .order('created_at');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, i) {
          final o = orders[i];

          return Card(
            child: ListTile(
              title: Text(o['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(o['address']),
                  Text("Pembayaran: ${o['payment_method']}"),
                ],
              ),
              trailing: Text("Rp ${o['total']}"),
            ),
          );
        },
      ),
    );
  }
}
