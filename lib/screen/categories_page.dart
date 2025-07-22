import 'package:flutter/cupertino.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';
import 'package:flutter/material.dart';
import '../styles/AppColors.dart';
import '../styles/AppTextStyles.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(title: "Category Page", showCartIcon: false),
            Expanded(
              child: Center(
                child: Text(
                  "Category Screen",
                  style: AppTextStyles.poppinsBold16.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
