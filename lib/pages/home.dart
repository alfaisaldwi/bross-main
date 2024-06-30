import 'package:bross_main/pages/login.dart';
import 'package:bross_main/pages/place_detail.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ThemeData _themeData;
  bool _isDarkMode = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isRefreshing = false;
    });
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeData = _isDarkMode ? _buildDarkTheme() : _buildLightTheme();
    });
  }

  _toggleTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    setState(() {
      _isDarkMode = isDarkMode;
      _themeData = isDarkMode ? _buildDarkTheme() : _buildLightTheme();
    });
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorStyle.lightPrimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorStyle.lightPrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ColorStyle.lightText),
        bodyMedium: TextStyle(color: ColorStyle.lightText),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorStyle.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorStyle.darkPrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ColorStyle.darkText),
        bodyMedium: TextStyle(color: ColorStyle.darkText),
      ),
    );
  }

  void navigateToProductDetail(BuildContext context, bool isDarkMode,
      String image, String name, String address, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetail(
          isDarkMode: isDarkMode,
          image: image,
          name: name,
          address: address,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'imagePath': 'assets/kaedo.jpg',
        'name': 'Coffe Kaedo',
        'address': 'Jl. Pahlawan No. 123, Kota Kamu',
        'description':
            'Kopi Kaedo adalah kopi pilihan terbaik dengan rasa yang lezat dan aroma yang memikat.',
        'rating': 5
      },
      {
        'imagePath': 'assets/loffe.jpg',
        'name': 'Coffe Loffe',
        'address': 'Jl. mantan No. 123, Kota Kamu',
        'description':
            'Kopi loffe adalah kopi pilihan terbaik dengan rasa yang lezat',
        'rating': 4
      },
      {
        'imagePath': 'assets/temu.jpg',
        'name': 'Coffe Temu',
        'address': 'Jl. arundam No. 123, Kota Kamu',
        'description': 'Kopi Temu adalah tempat kopi pilihan terbaik',
        'rating': 5
      },
      {
        'imagePath': 'assets/otten.jpg',
        'name': 'Coffe Otten',
        'address': 'Jl. taiwan No. 123, Kota Kamu',
        'description':
            'Kopi otten adalah tempat kopi dengan pelayanan terbaik.',
        'rating': 5
      },
      {
        'imagePath': 'assets/josami.jpg',
        'name': 'Coffe Josami',
        'address': 'Jl. mantan No. 123, Kota Kamu',
        'description':
            'Salah satu tempat nongkrong yang berada di hutan membuat kedai ini memiliki udara yang segar dan nyaman',
        'rating': 4
      },
      {
        'imagePath': 'assets/samiramen.jpg',
        'name': 'Coffe Samire ',
        'address': 'Jl. Trawas - Mojosari, Sukosari',
        'description':
            'Samiremen Cafe memiliki beragam menu kuliner khas nusantara yang bisa kamu cicipi, harganya pun cukup murah.',
        'rating': 5
      },
      {
        'imagePath': 'assets/bunga.jpg',
        'name': 'Bunga Cafe',
        'address': 'Jl. Raya Nongkojajar, Sawiran, Dawuhan Sengon',
        'description':
            'Beragam menu ditawarkan di kafe ini, mulai dari makanan, camilan ringan, hingga minuman. ',
        'rating': 5
      },
    ];
    return Scaffold(
      backgroundColor:
          _isDarkMode ? ColorStyle.darkBackground : ColorStyle.background,
      // backgroundColor: ColorStyle.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: _isDarkMode
                        ? ColorStyle.lightPrimary
                        : ColorStyle.darkPrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 30,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Cari Tempat\nTongkronganmu\nbersama Bross',
                              style: TextStyle(
                                color: ColorStyle.white,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Switch(
                                    value: _isDarkMode,
                                    onChanged: (value) {
                                      _toggleTheme(value);
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.logout,
                                    color: ColorStyle.white,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 130),
                      width: 320,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 8,
                            offset: Offset(4, 3),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            // Icon
                            const Icon(
                              Icons.search_rounded,
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 6),
                              height: 20,
                              child: const VerticalDivider(
                                thickness: 1,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Cari',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rekomendasi',
                    style: TextStyle(
                        fontSize: 16,
                        color: _isDarkMode
                            ? ColorStyle.darkText
                            : const Color.fromARGB(255, 190, 123, 30)),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: ColorStyle.primary,
                    ),
                    onPressed: _handleRefresh,
                  ),
                ],
              ),
            ),
            _isRefreshing
                ? Container(
                    height: 400,
                    child: const Align(
                        alignment: Alignment.center,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: ColorStyle.primary,
                        ))),
                  )
                : Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 1,
                        ),
                        items: products.map((product) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Image.asset(product['imagePath'],
                                      fit: BoxFit.fitWidth, height: 140),
                                  const SizedBox(height: 10),
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _isDarkMode
                                            ? ColorStyle.darkText
                                            : const Color.fromARGB(
                                                255, 190, 123, 30)),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: SizedBox(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                var product = products[index];
                                return InkWell(
                                  onTap: () {
                                    navigateToProductDetail(
                                      context,
                                      _isDarkMode,
                                      product['imagePath'],
                                      product['name'],
                                      product['address'],
                                      product['description'],
                                    );
                                  },
                                  child: Container(
                                    height: 250,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: ColorStyle.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 8,
                                          offset: Offset(4, 3),
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: Image.asset(
                                            product['imagePath'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    product['name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: ColorStyle.black,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.coffee,
                                                    color: ColorStyle.primary,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: List.generate(
                                                    product['rating'],
                                                    (index) => const Icon(
                                                      Icons.star,
                                                      color: ColorStyle.primary,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
          ]),
        ),
      ),
    );
  }
}
