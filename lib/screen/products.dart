import 'package:api/models/products_response.dart';
import 'package:api/screen/products_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget lstProducts(
  Future<List<ProductsResponse>> productsFuture,
  Future<List<String>> futureCategory,
  List<ProductsResponse> lstProduct,
  List<ProductsResponse> lstSearchProduct,
  void Function(BuildContext context, List<String> lstcategory) modalBottomSheetMenu,
  void Function(BuildContext context) restart,
) {
  return FutureBuilder<List>(
    future: Future.wait([productsFuture, futureCategory]),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (!snapshot.hasData) {
        return const Center(child: Text('No data available'));
      }

      final products = snapshot.data![0] as List<ProductsResponse>;
      final categories = snapshot.data![1] as List<String>;

      // Update lstProduct and lstSearchProduct if needed
      if (lstProduct.isEmpty) {
        lstProduct = products;
        lstSearchProduct = products;
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (keyword) {
                      if (keyword.isEmpty) {
                        lstSearchProduct = lstProduct;
                      } else {
                        lstSearchProduct = lstProduct.where((product) {
                          return product.title
                              .toLowerCase()
                              .contains(keyword.toLowerCase());
                        }).toList();
                      }
                      // Trigger rebuild
                      // ignore: invalid_use_of_protected_member
                      (context as StatefulElement).state.setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          modalBottomSheetMenu(context, categories);
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          restart(context);
                        },
                        icon: const Icon(Icons.restart_alt),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: lstSearchProduct.length,
              itemBuilder: (context, index) {
                final product = lstSearchProduct[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsDetail(products: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Icon(Icons.favorite_border),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}