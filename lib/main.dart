import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spark_talk_fake_store/screen/card_clothes_grid.dart';
import 'package:spark_talk_fake_store/styles/AppColors.dart';
import 'package:spark_talk_fake_store/styles/AppTextStyles.dart';
import 'package:spark_talk_fake_store/utils/app_router.dart';
import 'package:spark_talk_fake_store/widget/top_bar.dart';

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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TopBar(title: "Awesome Store"),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
          child: Text(
            'All Products',
            style: AppTextStyles.poppinsBold18.copyWith(
              color: AppColors.greyText,
            ),
          ),
        ),
        Expanded(
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CardClothesGrid(products: products),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: body),
    );
  }
}
