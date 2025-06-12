import 'package:flutter/material.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';

class ProductGrid extends StatelessWidget {
  final List<dynamic> products;
  final void Function(Map<String, dynamic> product)? onProductTap;

  const ProductGrid({super.key, required this.products, this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = products[index];
          return InkWell(
            onTap: () => onProductTap?.call(product),
            child: Card(
              color: AppColors.cardBackground,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12.0),
                      ),
                      child: Image.network(
                        product['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product['price']}',
                      style: AppTextStyles.poppinsBold18.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          '${product['rating']['rate']} (${product['rating']['count']})',
                          style: AppTextStyles.poppinsRegular16.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }
}
