import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/AppTextStyles.dart';

class SubtotalItem extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const SubtotalItem({super.key, required this.cartItems});

  void _handleCheckout(BuildContext context) {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maaf, belum ada item yang ditambahkan'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 120,
            left: 8,
            right: 8
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item berhasil dicheckout'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
              bottom: 120,
              left: 8,
              right: 8
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = cartItems.fold(0.0, (sum, item) {
      final price = (item['price'] as num?)?.toDouble() ?? 0.0;
      final quantity = item['quantity'] as int? ?? 1;
      return sum + (price * quantity);
    });

    final int totalQuantity = cartItems.fold(0, (sum, item) {
      return sum + (item['quantity'] as int? ?? 1);
    });

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal ($totalQuantity items)',
                style: AppTextStyles.poppinsRegular16.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${(subtotal * 100).round() / 100.0}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleCheckout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: AppTextStyles.poppinsMedium16.copyWith(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
