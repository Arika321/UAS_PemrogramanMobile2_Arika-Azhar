import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  // =============================
  // ADD TO CART
  // =============================
  Future<void> addToCart(ProductModel product) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    // cek apakah produk sudah ada
    final existing = await supabase
        .from('cart')
        .select()
        .eq('user_id', user.id)
        .eq('product_id', product.id)
        .maybeSingle();

    if (existing != null) {
      await supabase.from('cart').update({
        'qty': existing['qty'] + 1,
      }).eq('id', existing['id']);
    } else {
      await supabase.from('cart').insert({
        'user_id': user.id,
        'product_id': product.id,
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'qty': 1,
      });
    }
  }

  // =============================
  // GET CART
  // =============================
  Future<List> getCart() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final res =
        await supabase.from('cart').select().eq('user_id', user.id).order('id');

    return res;
  }

  // =============================
  // UPDATE QTY
  // =============================
  Future<void> updateQty(int id, int qty) async {
    await supabase.from('cart').update({
      'qty': qty,
    }).eq('id', id);
  }

  // =============================
  // DELETE CART ITEM
  // =============================
  Future<void> deleteCart(int id) async {
    await supabase.from('cart').delete().eq('id', id);
  }

  // =============================
  // CHECKOUT ORDER
  // =============================
  Future<void> checkoutOrder(
    String name,
    String address,
    String payment,
    int total,
  ) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    // simpan order
    await supabase.from('orders').insert({
      'user_id': user.id,
      'name': name,
      'address': address,
      'payment': payment,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
    });

    // kosongkan cart
    await supabase.from('cart').delete().eq('user_id', user.id);
  }
}
