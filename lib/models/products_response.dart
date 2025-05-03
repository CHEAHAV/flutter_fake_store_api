class ProductsResponse {
  final int id;
  final String title;
  final String description;
  final dynamic price;
  final String category;
  final String image;
  final Rating rating;

  ProductsResponse(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.image,
      required this.rating});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      rating: Rating(
        rate: json['rating']['rate'],
        count: json['rating']['count'],
      ),
    );
  }
}

class Rating {
  final dynamic rate;
  final int count;

  Rating({required this.rate, required this.count});
}
