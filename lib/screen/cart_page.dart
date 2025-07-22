import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spark_talk_fake_store/screen/SubtotalItem.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';
import '../styles/AppTextStyles.dart';
import '../utils/cart_manager.dart';
import 'card_clothes_vertical.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  void _handleBack(BuildContext context) {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager().cartItems;

    return SafeArea(
      child: Container(
        color: const Color(0xFFF9FAFB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: 'Cart', showBackButton: true, showCartIcon: false, onBack: () => _handleBack(context)),
            Expanded(
              child:
                  cartItems.isEmpty
                      ? const Center(child: Text('Cart is empty', style: AppTextStyles.poppinsBold16))
                      : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final isFirst = index == 0;
                          final isLast = index == cartItems.length - 1;
                          return Padding(
                            padding: EdgeInsets.only(
                              top: isFirst ? 12.0 : 4.0,
                              left: 12.0,
                              right: 12.0,
                              bottom: isLast ? 12.0 : 0.0,
                            ),
                            child: CartClothesVertical(
                              product: item,
                              initialQuantity: item['quantity'] ?? 1,
                              onQuantityChanged: (qty) {
                                setState(() {
                                  CartManager().updateQuantity(item, qty);
                                });
                              },
                              onRemove: () {
                                setState(() {
                                  CartManager().removeFromCart(item);
                                });
                              },
                            ),
                          );
                        },
                      ),
            ),
            SubtotalItem(cartItems: cartItems)
          ],
        ),
      ),
    );
  }
}
