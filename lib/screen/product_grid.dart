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
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildProductCard(context, products[index]),
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return InkWell(
      onTap: () => onProductTap?.call(product),
      borderRadius: BorderRadius.circular(12.0),
      child: Card(
        color: AppColors.cardBackground,
        elevation: 1.0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(12.0),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product['image']),
            _buildProductTitle(product['title']),
            _buildProductPrice(product['price']),
            _buildProductRating(product['rating']),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.poppinsRegular16,
      ),
    );
  }

  Widget _buildProductPrice(dynamic price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        '\$${price.toString()}',
        style: AppTextStyles.poppinsBold18.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildProductRating(dynamic rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16.0),
          const SizedBox(width: 4.0),
          Text(
            '${rating['rate']} (${rating['count']})',
            style: AppTextStyles.poppinsRegular16.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}