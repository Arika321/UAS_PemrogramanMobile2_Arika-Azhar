import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'product_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  String selectedCategory = "Semua";

  final List<String> categories = [
    "Semua",
    "Original",
    "Favorit",
    "BestSeller",
  ];

  // kategori KHUSUS untuk produk
  final List<String> productCategories = [
    "Original",
    "Favorit",
    "BestSeller",
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    final names = [
      "Dodol Wijen",
      "Dodol Coklat",
      "Dodol Meuseukat",
      "Galamai",
      "Lempok Durian",
      "Dodol Kerinci",
      "Wajit Cililin",
      "Jenang Kelapa",
      "Dodol Durian",
      "Dodol Mandailing",
      "Dodol Kacang",
      "Dodol Susu",
      "Dodol Pandan",
      "Dodol Strawberry",
      "Dodol Mangga",
      "Dodol Nanas",
      "Dodol Tape",
      "Dodol Jahe",
      "Dodol Kopi",
      "Dodol Original",
    ];

    allProducts = List.generate(names.length, (i) {
      return ProductModel(
        id: i + 1,
        name: names[i],
        price: 25000 + (i * 2000),
        image: "assets/images/dodol${i + 1}.png",
        rating: 4.5,
        category: categories[i % categories.length],
      );
    });

    filteredProducts = allProducts;
    setState(() {});
  }

  void searchProduct(String text) {
    filteredProducts = allProducts
        .where((p) => p.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    setState(() {});
  }

  void filterCategory(String cat) {
    selectedCategory = cat;

    if (cat == "Semua") {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts.where((p) => p.category == cat).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Dodol"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // BANNER
          Container(
            margin: const EdgeInsets.all(12),
            height: 130,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                "PROMO HARI INI 🔥\nDiskon Sampai 30%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: searchProduct,
              decoration: InputDecoration(
                hintText: "Cari dodol...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // CATEGORY
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final c = categories[i];
                final active = c == selectedCategory;

                return GestureDetector(
                  onTap: () => filterCategory(c),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: active ? Colors.brown : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      c,
                      style: TextStyle(
                        color: active ? Colors.white : Colors.brown,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // GRID PRODUK
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) {
                final product = filteredProducts[i];

                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
