import 'package:http/http.dart' as http;
import 'productData.dart';
import 'dart:convert';

class ProductService { 
  static const baseUrl = 'http://172.30.1.26:3030';
  static const headers = {'Content-Type': 'application/json'};

  static Future<List<Products>> getProduct(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/$type'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Products: ${response.reasonPhrase}');
    }
  }

  static Future<Products> createProduct(Products product) async {
    final jsonBody = jsonEncode(product.toJson());
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Products.fromJson(json);
    } else {
      throw Exception('Failed to create product');
    }
  }

  static Future<Products> updateProduct(Products product) async {
    final jsonBody = jsonEncode(product.toJson());
    final response = await http.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Products.fromJson(json);
    } else {
      throw Exception('Failed to update product');
    }
  }

  static Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }

  static Future<int> getLikeCount(String productType, String productId) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/$productType/$productId'));

    if (response.statusCode == 200) {
      final productData = jsonDecode(response.body);
      return productData['likes'] ?? 0; 
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading like count: $e');
    return 0;
  }
}

}
