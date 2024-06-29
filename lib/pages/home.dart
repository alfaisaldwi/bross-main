import 'package:bross_main/pages/login.dart';
import 'package:bross_main/pages/product_detail.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:flutter/material.dart';
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
    await Future.delayed(Duration(seconds: 3)); // Menunggu 3 detik
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
        // tambahkan gaya teks lainnya sesuai kebutuhan
      ),
      // tambahkan tema lainnya sesuai kebutuhan
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
        // tambahkan gaya teks lainnya sesuai kebutuhan
      ),
      // tambahkan tema lainnya sesuai kebutuhan
    );
  }

  void navigateToProductDetail(BuildContext context, bool isDarkMode,
      String image, String name, String address, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(
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
      }
    ];
    return Scaffold(
      backgroundColor:
          _isDarkMode ? ColorStyle.darkBackground : ColorStyle.background,
      // backgroundColor: ColorStyle.background,
      body: SingleChildScrollView(
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cari Tempat Tongkronganmu \nbersama Bross',
                            style: TextStyle(
                              color: ColorStyle.white,
                              fontSize: 16,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: _isDarkMode,
                              onChanged: (value) {
                                _toggleTheme(value);
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: _handleRefresh,
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
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 130),
                    width: 320,
                    height: 40, // Ganti ukuran yang diperlukan
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
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
                      fontSize: 14,
                      color: _isDarkMode
                          ? ColorStyle.darkText
                          : ColorStyle.lightText),
                ),
                Text(
                  'Selengkapnya',
                  style: TextStyle(
                      fontSize: 14,
                      color: _isDarkMode
                          ? ColorStyle.darkText
                          : ColorStyle.lightText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: _isRefreshing
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 700,
                    child: GridView.builder(
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
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: ColorStyle.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 8,
                                    offset: Offset(4, 3),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    product['imagePath'],
                                    fit: BoxFit.fitWidth,
                                    height: 120,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product['name'],
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
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Tambahkan logika untuk navigasi ke halaman sesuai dengan index yang dipilih
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
