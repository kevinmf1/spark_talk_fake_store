import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductController {
  List<dynamic> products = [];
  bool isLoading = true;

  Future<void> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        products = json.decode(response.body);
      }
    } catch (_) {}
    isLoading = false;
  }
}