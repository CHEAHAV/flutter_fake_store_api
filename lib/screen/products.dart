
  import 'package:api/models/products_response.dart';
import 'package:api/screen/products_detail.dart';
import 'package:flutter/material.dart';

FutureBuilder<List<ProductsResponse>> products(dynamic productsFuture) {
    return FutureBuilder<List<ProductsResponse>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final products = snapshot.data!;
          return GridView.builder(
              padding: const EdgeInsets.all(8.0), // Padding around the grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio:
                    0.7, // Adjust the height/width ratio of each grid item
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductsDetail(products: products[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4, // Shadow effect for the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            products[index].image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit
                                .cover, // Cover the entire area of the card
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].title,
                                  maxLines: 2, // Limit to 2 lines
                                  overflow: TextOverflow
                                      .ellipsis, // Ellipsis for overflow
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$ ${products[index].price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                    Icon(Icons.favorite_border), // Heart icon
                                  ],
                                ), // Heart icon
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              });
        });
  }
