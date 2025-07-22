import 'package:flutter/material.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';

class PromoCard extends StatelessWidget {
  final ScrollController? scrollController;

  const PromoCard({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Color(0xFFDDDDDD), width: 1.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF3C81F6), Color(0xFF4F47E5)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(child: _PromoText()),
                _ShopNowButton(scrollController: scrollController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoText extends StatelessWidget {
  const _PromoText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summer Sale!',
          style: AppTextStyles.poppinsBold18.copyWith(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        Text(
          'Up to 50% off selected items.',
          style: AppTextStyles.poppinsRegular16.copyWith(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}

class _ShopNowButton extends StatelessWidget {
  final ScrollController? scrollController;

  const _ShopNowButton({this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF3C81F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        textStyle: AppTextStyles.poppinsBold16.copyWith(fontSize: 14),
      ),
      onPressed: () {
        scrollController?.animateTo(
          500,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: const Text('Shop Now'),
    );
  }
}