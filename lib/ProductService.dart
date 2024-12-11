import 'package:http/http.dart' as http;
import 'productData.dart';
import 'dart:convert';

class ProductService {
  static const baseUrl = 'http://172.24.80.100:3000';
  static const headers = {'Content-Type': 'application/json'};

  static Future<List<Products>> getProduct(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/$type'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Products');
    }
  }

  static Future<Products> createProduct(String type, Products product) async {
    final jsonBody = jsonEncode(product.toJson());
    final response = await http.post(
      Uri.parse('$baseUrl/$type'),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Products.fromJson(json);
    } else {
      throw Exception('Failed to create Products');
    }
  }

  static Future<Products> updateProduct(String type, Products product) async {
    final jsonBody = jsonEncode(product.toJson());
    final response = await http.put(
      Uri.parse('$baseUrl/$type/${product.id}'),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Products.fromJson(json);
    } else {
      throw Exception('Failed to update Products');
    }
  }

  static Future<void> deleteProduct(String type, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$type/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete Products');
    }
  }
}
