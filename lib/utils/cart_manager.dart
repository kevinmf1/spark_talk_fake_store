class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    final index = _cartItems.indexWhere((item) => item['title'] == product['title']);
    if (index != -1) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
    } else {
      final newProduct = Map<String, dynamic>.from(product);
      newProduct['quantity'] = product['quantity'] ?? 1;
      _cartItems.add(newProduct);
    }
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.remove(product);
  }

  void updateQuantity(Map<String, dynamic> product, int quantity) {
    final index = _cartItems.indexWhere((item) => item['title'] == product['title']);
    if (index != -1) {
      _cartItems[index]['quantity'] = quantity;
    }
  }
}