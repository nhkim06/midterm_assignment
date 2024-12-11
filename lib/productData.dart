import 'dart:convert';

class Products {
  final String name; 
  final String manufacturer;
  final String image;
  final int price;
  final String id;
  final String description;
  final int likes;
  final bool selected;

  Products({
    required this.name,
    required this.manufacturer,
    required this.image,
    required this.price,
    required this.id,
    required this.description,
    required this.likes,
    required this.selected
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String,
      image: json['image'] as String,
      price: json['price'] as int,
      id: json['id'] as String,
      description: json['description'] as String,
      likes: json['likes'] as int,
      selected: json['selected'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'manufacturer': manufacturer, 
      'image': image, 
      'price': price, 
      'id': id, 
      'description': description, 
      'likes': likes, 
      'selected': selected,
    };
  }
}