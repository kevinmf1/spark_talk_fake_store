import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/AppColors.dart';
import '../styles/AppTextStyles.dart';
import '../widget/top_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(title: "Profile Page", showCartIcon: false),
            Expanded(
              child: Center(
                child: Text(
                  "Profile Screen",
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
