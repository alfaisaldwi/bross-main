import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String image;
  final String name;
  final String address;
  final String description;
  final bool isDarkMode;

  const ProductDetail({
    Key? key,
    required this.image,
    required this.name,
    required this.address,
    required this.description,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isFavorite = false; // Variable to track favorite status

  // Example list of reviews (replace with your own data or fetch dynamically)
  List<Map<String, String>> reviews = [
    {
      'name': 'agung',
      'comment': 'Tempat kopi disini enak',
      'rating': '5',
    },
    {
      'name': 'Dwi',
      'comment': 'Mushola nya nyaman banget',
      'rating': '5',
    },
    {
      'name': 'Nawal',
      'comment': 'mantapp',
      'rating': '4',
    },
  ];

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        // Add to favorite list (in real app, you might store it persistently)
        favoriteProducts.add({
          'image': widget.image,
          'name': widget.name,
          'address': widget.address,
          'description': widget.description,
        });
      } else {
        // Remove from favorite list
        favoriteProducts
            .removeWhere((product) => product['name'] == widget.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: widget.isDarkMode ? Colors.grey[800] : Colors.grey[50],
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.address,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ulasan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                reviews[index]['name'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            reviews[index]['comment'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: List.generate(
                              int.parse(reviews[index]['rating'] ?? '0'),
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example global variable to store favorite products
List<Map<String, String>> favoriteProducts = [];
