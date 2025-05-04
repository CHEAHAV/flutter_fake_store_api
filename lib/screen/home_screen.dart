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
  late Future<List<String>> futureCategory;
  late Future<List<ProductsResponse>> productsByCategoryFuture;

  @override
  void initState() {
    productsFuture = ApiHelper.getProduct(context);
    futureCategory = ApiHelper.getProductCategory(context);
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
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: products(
          productsFuture, futureCategory, modalBottomSheetMenu, restart),
    );
  }

  void modalBottomSheetMenu(BuildContext context, List<String> lstcategory) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 300,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: ListView.builder(
                    itemCount: lstcategory.length,
                    itemBuilder: (context, index) {
                      String categoryName = lstcategory[index];
                      return ListTile(
                        leading: Icon(Icons.category), // Category icon
                        title: Text(lstcategory[index]),
                        onTap: () {
                          productsFuture = ApiHelper.getProductBycategoryName(
                              context, categoryName);
                          setState(() {
                            productsFuture;
                          });
                          Navigator.pop(context);
                        },
                      );
                    })),
          );
        });
  }

  void restart(BuildContext context) {
    setState(() {
      productsFuture = ApiHelper.getProduct(context);
    });
  }
}
