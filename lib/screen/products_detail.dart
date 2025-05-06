import 'package:api/models/products_response.dart';
import 'package:api/screen/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatelessWidget {
  const ProductsDetail({super.key, required this.products});

  final ProductsResponse products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, // This makes the drawer icon white
          ),
          title: Text(
            "Product Detail",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true, // This makes the drawer icon white
        ),
        body: Card(
          elevation: 4, // Shadow effect for the card
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        // Rounded corners for the image
                        child: CachedNetworkImage(
                          imageUrl: products.image,
                          height: 500,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.title,
                          maxLines: 2, // Limit to 2 lines
                          overflow:
                              TextOverflow.ellipsis, // Ellipsis for overflow
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          products.description,
                          maxLines: 8,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          products.category,
                          maxLines: 5, // Limit to 2 lines
                          overflow:
                              TextOverflow.ellipsis, // Ellipsis for overflow
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Price : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\$ ${products.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.favorite_border), // Heart icon
                          ],
                        ),

                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Rating : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: products.rating.rate.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )),
                            RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Count : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: products.rating.count.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),

                        const SizedBox(height: 4), // Heart icon
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen())),
                          child: Center(
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: 300,
                              ),
                              child: Card(
                                elevation: 4, // Shadow effect for the card
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "ADD TO CART",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
