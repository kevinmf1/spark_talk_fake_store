import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      // margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.bottomNavigationActive,
        unselectedItemColor: AppColors.bottomNavigationInactive,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyles.poppinsBold16.copyWith(fontSize: 12.0),
        unselectedLabelStyle: AppTextStyles.poppinsRegular16.copyWith(fontSize: 12.0),
        onTap: onTap,
        elevation: 0,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? AppColors.bottomNavigationActive
                      : AppColors.bottomNavigationInactive,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SvgPicture.asset(
                'assets/icons/ic_category.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColors.bottomNavigationActive
                      : AppColors.bottomNavigationInactive,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SvgPicture.asset(
                'assets/icons/ic_cart.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? AppColors.bottomNavigationActive
                      : AppColors.bottomNavigationInactive,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SvgPicture.asset(
                'assets/icons/ic_profile.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? AppColors.bottomNavigationActive
                      : AppColors.bottomNavigationInactive,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
