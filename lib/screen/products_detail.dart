import 'package:api/models/products_response.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatelessWidget {
  const ProductsDetail({super.key, required this.products});

  final ProductsResponse products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
      elevation: 4, // Shadow effect for the card
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Expanded(
              child: Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    // Rounded corners for the image
                    child: Image.network(
                      products.image,
                      height: 500,
                      width: double.infinity,
                      fit: BoxFit.cover, // Cover the entire area of the card
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
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      products.description,
                      maxLines: 5, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      products.category,
                      maxLines: 5, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
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
                        RichText(text: TextSpan(
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
                        RichText(text: TextSpan(
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
                    ), // Heart icon
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
