import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductService {
  final supabase = Supabase.instance.client;

  Future<void> addToCart(ProductModel product) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('cart').insert({
      'user_id': user.id,
      'product_id': product.id,
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'qty': 1,
    });
  }

  Future<List> getCart() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];
    return await supabase.from('cart').select().eq('user_id', user.id);
  }

  Future<void> updateQty(int id, int qty) async {
    await supabase.from('cart').update({'qty': qty}).eq('id', id);
  }

  Future<void> deleteCart(int id) async {
    await supabase.from('cart').delete().eq('id', id);
  }

  Future<void> checkoutOrder(
    String name,
    String address,
    String payment,
    int total,
  ) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('orders').insert({
      'user_id': user.id,
      'name': name,
      'address': address,
      'payment_method': payment,
      'total': total,
    });

    await supabase.from('cart').delete().eq('user_id', user.id);
  }
}
