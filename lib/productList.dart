import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Product Model
class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String sku;
  final String category;
  final String subCategory;
  final String productThumbnail;
  final String youtubeLink;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sku,
    required this.category,
    required this.subCategory,
    required this.productThumbnail,
    required this.youtubeLink,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Extract image URLs from the images array in the JSON response
    List<String> imageUrls = [];
    if (json['images'] != null) {
      for (var image in json['images']) {
        imageUrls.add(image['image_path']);
      }
    }

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      sku: json['sku'],
      category: json['category'],
      subCategory: json['sub_category'],
      productThumbnail: json['product_thumbnail'],
      youtubeLink: json['youtube_link'],
      images: imageUrls,
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch products from API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://mystic.great-site.net/admin_dashboard/get_product.php?product_id=1'));


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          final productData = data['product'];
          final product = Product.fromJson(productData);
          setState(() {
            products = [product];  // Store the single product as a list
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load products');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;  // Stop loading on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(child: Text("No products available"))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.productThumbnail),
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      onTap: () {
                        // You can navigate to a product detail page if needed
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductDetailScreen(product: product),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
    );
  }
}
