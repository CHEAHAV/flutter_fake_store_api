import 'package:api/screen/products_detail.dart';
import 'package:flutter/material.dart';

FutureBuilder<List> products(
    dynamic productsFuture,
    dynamic futureCategory,
    void Function(BuildContext context, List<String> lstcategory)
        modalBottomSheetMenu,
    restart) {
  return FutureBuilder<List>(
      future: Future.wait([productsFuture, futureCategory]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
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
                          prefixIcon: Icon(Icons.search), // Search icon
                          hintText: "Search", // Placeholder text
                          hintStyle: TextStyle(
                              color: Colors.grey), // Placeholder text style
                          filled: true, // Fill the background
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey), // Border color
                        color: Colors.grey[300] // Background color
                        ),
                    child: Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.filter_list), // Filter icon
                            onPressed: () {
                              modalBottomSheetMenu(context, snapshot.data![1]);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                restart(context);
                              },
                              icon: Icon(Icons.restart_alt)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(8.0), // Padding around the grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                    childAspectRatio:
                        0.7, // Adjust the height/width ratio of each grid item
                  ),
                  itemCount:
                      snapshot.data![0].length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    final products = snapshot.data![0];
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
                                        Icon(Icons
                                            .favorite_border), // Heart icon
                                      ],
                                    ), // Heart icon
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      });
}
