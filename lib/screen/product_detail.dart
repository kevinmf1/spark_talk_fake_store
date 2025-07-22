import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/string_extensions.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';
import '../utils/cart_manager.dart';

class ProductDetail extends StatelessWidget {
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImage;
  final String productCategory;
  final double productRating;
  final int productRatingCount;

  const ProductDetail({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productCategory,
    required this.productRating,
    required this.productRatingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(title: 'Product Details', showBackButton: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductImage(imageUrl: productImage),
                    _CategoryBadge(category: productCategory),
                    _ProductTitle(title: productName),
                    _ProductRating(
                      rating: productRating,
                      count: productRatingCount,
                    ),
                    _ProductPrice(price: productPrice),
                    _SectionTitle(title: 'Description'),
                    _ProductDescription(description: productDescription),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AddToCartButton(
        productName: productName,
        productDescription: productDescription,
        productCategory: productCategory,
        productPrice: productPrice,
        productImage: productImage,
        productRating: productRating,
        productRatingCount: productRatingCount,
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 250,
    color: const Color(0xFFE5E7EB),
    child: Image.network(imageUrl, fit: BoxFit.contain),
  );
}

class _CategoryBadge extends StatelessWidget {
  final String category;

  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final badgeStyle = getCategoryBadgeStyle(category);
    final backgroundColor = badgeStyle['background']!.first;
    final textColor = badgeStyle['text']!.first;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          category.capitalizeEachWord(),
          style: AppTextStyles.poppinsRegular16.copyWith(
            fontSize: 12.0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _ProductTitle extends StatelessWidget {
  final String title;

  const _ProductTitle({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

class _ProductRating extends StatelessWidget {
  final double rating;
  final int count;

  const _ProductRating({required this.rating, required this.count});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        child: RatingBarIndicator(
          rating: rating,
          itemBuilder:
              (context, _) => const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 24.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: Text(
          '$rating ($count Reviews)',
          style: AppTextStyles.poppinsRegular16,
        ),
      ),
    ],
  );
}

class _ProductPrice extends StatelessWidget {
  final double price;

  const _ProductPrice({required this.price});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      '\$${price.toStringAsFixed(2)}',
      style: AppTextStyles.poppinsBold24.copyWith(fontSize: 28),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
    child: Text(
      title,
      style: AppTextStyles.poppinsBold18.copyWith(
        color: const Color(0xFF1F2937),
      ),
    ),
  );
}

class _ProductDescription extends StatelessWidget {
  final String description;

  const _ProductDescription({required this.description});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      top: 8.0,
      bottom: 16.0,
    ),
    child: Text(
      description.capitalizeFirstSentence(),
      style: AppTextStyles.poppinsLight16.copyWith(
        color: const Color(0xFF4B5563),
      ),
      textAlign: TextAlign.justify,
    ),
  );
}

class _AddToCartButton extends StatelessWidget {
  final String productName, productDescription, productCategory, productImage;
  final double productPrice, productRating;
  final int productRatingCount;

  const _AddToCartButton({
    required this.productName,
    required this.productDescription,
    required this.productCategory,
    required this.productPrice,
    required this.productImage,
    required this.productRating,
    required this.productRatingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            final cartManager = CartManager();
            final productData = {
              'title': productName,
              'description': productDescription,
              'category': productCategory,
              'price': productPrice,
              'image': productImage,
              'rating': {'rate': productRating, 'count': productRatingCount},
            };
            final alreadyInCart = cartManager.cartItems.any(
              (item) => item['title'] == productName,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  alreadyInCart
                      ? 'Product is already in the cart!'
                      : 'Added to cart!',
                ),
              ),
            );
            if (!alreadyInCart) cartManager.addToCart(productData);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            textStyle: AppTextStyles.poppinsBold18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Add to Cart',
            style: AppTextStyles.poppinsBold16.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
