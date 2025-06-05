import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/string_extensions.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';

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
                    Container(
                      width: double.infinity,
                      height: 250,
                      color: const Color(0xFFE5E7EB), // light grey
                      child: Image.network(
                        productImage,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          productCategory.capitalizeEachWord(),
                          style: AppTextStyles.poppinsRegular16.copyWith(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 8.0,
                        top: 8.0,
                      ),
                      child: Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            bottom: 8.0,
                          ),
                          child: RatingBarIndicator(
                            rating: productRating,
                            itemBuilder:
                                (context, index) =>
                                    const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 24.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            '$productRating ($productRatingCount Reviews)',
                            style: AppTextStyles.poppinsRegular16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '\$${productPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.poppinsBold24.copyWith(
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                      ),
                      child: Text(
                        'Description',
                        style: AppTextStyles.poppinsBold18.copyWith(
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                        bottom: 16.0,
                      ),
                      child: Text(
                        productDescription.capitalizeFirstSentence(),
                        style: AppTextStyles.poppinsLight16.copyWith(
                          color: Color(0xFF4B5563),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              // Add to cart logic
            },
            child: Text(
              'Add to Cart',
              style: AppTextStyles.poppinsBold16.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2563EB), // biru
              textStyle: AppTextStyles.poppinsBold18,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // sudut 8
              ),
            ),
          ),
        ),
      ),
    );
  }
}
