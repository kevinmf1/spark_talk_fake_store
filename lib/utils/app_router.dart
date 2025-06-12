import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spark_talk_fake_store/main.dart';
import 'package:spark_talk_fake_store/screen/cart_page.dart';
import 'package:spark_talk_fake_store/screen/categories_page.dart';
import 'package:spark_talk_fake_store/screen/profile_page.dart';

import '../screen/product_detail.dart';
import '../styles/CustomBottomNavigationBar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => MyHomePage(),
        ),
        GoRoute(
          path: '/categories',
          name: 'categories',
          builder: (context, state) => const CategoriesPage(),
        ),
        GoRoute(
          path: '/cart',
          name: 'cart',
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      name: 'productDetail',
      builder: (context, state) {
        // Pass product data via state.extra or fetch by id
        final product = state.extra as Map<String, dynamic>;
        return ProductDetail(
          productName: product['title'],
          productDescription: product['description'],
          productPrice: (product['price'] as num).toDouble(),
          productImage: product['image'],
          productCategory: product['category'],
          productRating: (product['rating']['rate'] as num).toDouble(),
          productRatingCount: product['rating']['count'],
        );
      },
    ),
  ],
);

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static const tabs = ['/', '/categories', '/cart', '/profile'];

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final List<int> _tabHistory = [0];

  int _locationToTabIndex(String location) {
    final index = MainScaffold.tabs.indexWhere((path) => location == path);
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToTabIndex(location);

    if (_tabHistory.isEmpty || _tabHistory.last != currentIndex) {
      _tabHistory.add(currentIndex);
    }

    return WillPopScope(
      onWillPop: () async {
        if (_tabHistory.length > 1) {
          _tabHistory.removeLast();
          final previousTab = _tabHistory.last;
          context.go(MainScaffold.tabs[previousTab]);
          return false; // Prevent default pop
        }
        return true; // Exit app
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (MainScaffold.tabs[index] != location) {
              context.go(MainScaffold.tabs[index]);
            }
          },
        ),
      ),
    );
  }
}