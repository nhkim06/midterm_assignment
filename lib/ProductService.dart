import 'package:http/http.dart' as http;
import 'productData.dart';
import 'dart:convert';

class ProductService { 
  static const baseUrl = 'http://192.168.0.139:3030';
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

  static Future<Products> getOneProduct(String type, String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Products.fromJson(json);
    } else {
      throw Exception('Failed to load Product: ${response.reasonPhrase}');
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

}
class ProductCategories {
    static final List<String> categories = ['의자', '책상', '소파', '침대', '식탁'];
    static final Map<String, Future<List<Products>>> products = {
      '의자': ProductService.getProduct('chairs'),
      '책상': ProductService.getProduct('desks'), 
      '소파': ProductService.getProduct('sofas'),
      '침대': ProductService.getProduct('beds'),
      '식탁': ProductService.getProduct('tables'),
    };
  }