import 'package:flutter/material.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool showBackButton;

  const TopBar({
    super.key,
    required this.title,
    this.trailing,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.greyBorder, width: 1.0),
          bottom: BorderSide(color: AppColors.greyBorder, width: 1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              SizedBox(
                height: 28,
                width: 28,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  constraints: const BoxConstraints(),
                ),
              )
            else
              const SizedBox(width: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                child: Text(
                  title,
                  style: AppTextStyles.poppinsBold18,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            trailing ?? const Icon(Icons.shopping_cart),
          ],
        ),
      ),
    );
  }
}
