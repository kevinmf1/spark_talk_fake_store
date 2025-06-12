import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spark_talk_fake_store/screen/product_grid.dart';
import 'package:spark_talk_fake_store/screen/promo_card.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/app_router.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';

import 'controller/product_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ProductController _controller = ProductController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.fetchProducts().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(title: "Awesome Store"),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(child: PromoCard(scrollController: _scrollController)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text(
                        'All Products',
                        style: AppTextStyles.poppinsBold18.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                    ),
                  ),
                  _controller.isLoading
                      ? const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      )
                      : ProductGrid(
                        products: _controller.products,
                        onProductTap: (product) {
                          context.push(
                            '/product/${product['id']}',
                            extra: product,
                          );
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
