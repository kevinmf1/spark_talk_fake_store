import 'package:flutter/material.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/string_extensions.dart';

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
    this.onRemove
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

  void _changeQuantity(int delta) {
    setState(() {
      quantity = (quantity + delta).clamp(1, 99);
    });
    widget.onQuantityChanged?.call(quantity);
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
          children: [
            Card(
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
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
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
                    widget.product['category']
                        .toString()
                        .capitalizeFirstSentence(),
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.poppinsLight16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product['price']}',
                    style: AppTextStyles.poppinsBold18.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     const Icon(Icons.star, color: Colors.amber, size: 16.0),
                  //     const SizedBox(width: 4.0),
                  //     Text(
                  //       '${widget.product['rating']['rate']} (${widget.product['rating']['count']})',
                  //       style: AppTextStyles.poppinsRegular16.copyWith(
                  //         color: AppColors.textSecondary,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed:
                          quantity > 1 ? () => _changeQuantity(-1) : null,
                      color: AppColors.bottomNavigationActive,
                    ),
                    Text('$quantity', style: AppTextStyles.poppinsBold16),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => _changeQuantity(1),
                      color: AppColors.bottomNavigationActive,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: widget.onRemove,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    textStyle: AppTextStyles.poppinsRegular16,
                  ),
                  child: const Text('Remove'),
                ),
              ],
            ),
            // const SizedBox(width: 12),
            // Column(
            //   children: [
            //     IconButton(
            //       icon: const Icon(Icons.add_circle_outline),
            //       onPressed: () => _changeQuantity(1),
            //       color: AppColors.bottomNavigationActive,
            //     ),
            //     Text('$quantity', style: AppTextStyles.poppinsBold16),
            //     IconButton(
            //       icon: const Icon(Icons.remove_circle_outline),
            //       onPressed: quantity > 1 ? () => _changeQuantity(-1) : null,
            //       color: AppColors.bottomNavigationActive,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
