import 'package:bross_main/model/favorite_model.dart';
import 'package:bross_main/pages/booking.dart';
import 'package:flutter/material.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:bross_main/model/booking_model.dart';

class PlaceDetail extends StatefulWidget {
  final String image;
  final String name;
  final String address;
  final String description;
  final bool isDarkMode;

  const PlaceDetail({
    Key? key,
    required this.image,
    required this.name,
    required this.address,
    required this.description,
    required this.isDarkMode,
  }) : super(key: key);

  // List untuk menyimpan produk favorit
  static List<Product> favoriteProducts = [];

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    final List<Review> reviews = [
      Review(name: 'Agung', review: 'Tempat kopi disini enak', rating: 5),
      Review(name: 'Dwi', review: 'Mushola nya nyaman banget', rating: 5),
      Review(name: 'Nawal', review: 'mantapp', rating: 4),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingPage(
                image: widget.image,
                name: widget.name,
              ),
            ),
          );
        },
        label: Text('Booking'),
        icon: Icon(Icons.check_circle_outline_outlined),
        backgroundColor: !widget.isDarkMode
            ? ColorStyle.darkPrimary
            : ColorStyle.lightPrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: widget.isDarkMode
            ? ColorStyle.lightPrimary
            : ColorStyle.darkPrimary,
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
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      bool isFavorite = PlaceDetail.favoriteProducts
                          .any((product) => product.name == widget.name);

                      if (!isFavorite) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Sukses'),
                                  SizedBox(height: 8),
                                  Text(
                                      'Tempat ini berhasil ditambahkan ke Favorit.'),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Oke'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        PlaceDetail.favoriteProducts.add(Product(
                          image: widget.image,
                          name: widget.name,
                          address: widget.address,
                          description: widget.description,
                        ));
                      } else {
                        PlaceDetail.favoriteProducts.removeWhere(
                            (product) => product.name == widget.name);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Center(
                              child: Text('Tempat dihapus dari Favorit')),
                        ));
                      }
                      setState(() {});
                    },
                    child: Text(
                      PlaceDetail.favoriteProducts
                              .any((product) => product.name == widget.name)
                          ? 'Hapus dari Favorit'
                          : 'Tambah ke Favorit',
                      style: TextStyle(color: ColorStyle.dark),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviews[index].name,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    reviews[index].review,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      reviews[index].rating,
                                      (i) => Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String name;
  final String review;
  final int rating;

  Review({required this.name, required this.review, required this.rating});
}
