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

}