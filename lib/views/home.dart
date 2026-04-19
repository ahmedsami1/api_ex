import 'package:api_ex/models/product_model.dart';
import 'package:api_ex/services/get_all_product.dart';
import 'package:api_ex/widgets/product_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ProductService productService;
  @override
  void initState() {
    super.initState();
    productService = ProductService(Dio());
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productService.getAllProducts(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {

            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}

