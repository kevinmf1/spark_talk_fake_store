import 'package:flutter/material.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/string_extensions.dart';
import 'increment_decrement_button.dart';

class CartClothesVertical extends StatefulWidget {
  final Map<String, dynamic> product;
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;
  final VoidCallback? onRemove;

  const CartClothesVertical({
    super.key,
    required this.product,
    this.initialQuantity = 1,
    this.onQuantityChanged,
    this.onRemove,
  });

  @override
  State<CartClothesVertical> createState() => _CartClothesVerticalState();
}

class _CartClothesVerticalState extends State<CartClothesVertical> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0xFFDDDDDD), width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            const SizedBox(width: 16),
            Expanded(child: _buildProductInfo()),
            const SizedBox(width: 12),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Color(0xFFDDDDDD), width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          widget.product['image'],
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.poppinsRegular16,
        ),
        const SizedBox(height: 8),
        Text(
          widget.product['category'].toString().capitalizeFirstSentence(),
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.poppinsLight16.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${widget.product['price']}',
          style: AppTextStyles.poppinsBold18.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        IncrementDecrementButton(
          initialValue: quantity,
          onChanged: (value) {
            setState(() {
              quantity = value;
            });
            widget.onQuantityChanged?.call(value);
          },
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: widget.onRemove,
          child: Text(
            'Remove',
            style: AppTextStyles.poppinsRegular16.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}