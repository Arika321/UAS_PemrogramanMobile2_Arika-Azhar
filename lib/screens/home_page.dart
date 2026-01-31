import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../widgets/product_card.dart';
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

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    final names = [
      "Dodol Wijen",
      "Dodol Coklat",
      "Dodol Durian",
      "Dodol Pandan",
      "Dodol Strawberry",
      "Dodol Mangga",
      "Dodol Original",
    ];

    allProducts = List.generate(names.length, (i) {
      return ProductModel(
        id: i + 1,
        name: names[i],
        price: 25000 + (i * 3000),
        image: "assets/images/dodol${i + 1}.png",
        rating: 4.5,
        category: categories[(i % 3) + 1],
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
      ),
      body: Column(
        children: [
          // ================= BANNER =================
          Container(
            margin: const EdgeInsets.all(12),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                "OLEH OLEH GARUT 🔥\n BELANJA DI DODOL ASGAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ================= SEARCH =================
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

          // ================= CATEGORY =================
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final c = categories[index];
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

          // ================= GRID =================
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
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
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
