import 'package:api/models/products_response.dart';
import 'package:api/screen/drawers.dart';
import 'package:api/screen/products.dart';
import 'package:api/services/api_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductsResponse>> productsFuture;

  @override
  void initState() {
    productsFuture = ApiHelper.getProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawers(context),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // This makes the drawer icon white
        ),
        centerTitle: true,
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: products(productsFuture),
    );
  }
}
