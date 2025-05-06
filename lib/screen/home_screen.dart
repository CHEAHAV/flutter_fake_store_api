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
  List<ProductsResponse> lstProduct = [];
  List<ProductsResponse> lstSearchProduct = [];
  String searchKeyword = '';
  final TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

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
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: lstProducts(
        productsFuture,
        futureCategory,
        lstProduct,
        lstSearchProduct,
        modalBottomSheetMenu,
        restart,
      ),
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: ListView.builder(
              itemCount: lstcategory.length,
              itemBuilder: (context, index) {
                String categoryName = lstcategory[index];
                return ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(categoryName),
                  onTap: () {
                    setState(() {
                      productsFuture =
                          ApiHelper.getProductBycategoryName(context, categoryName);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void restart(BuildContext context) {
    setState(() {
      productsFuture = ApiHelper.getProduct(context);
    });
  }
}