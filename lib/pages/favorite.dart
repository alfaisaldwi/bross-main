import 'package:bross_main/pages/place_detail.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isDarkMode ? ColorStyle.darkBackground : ColorStyle.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorit',
          style: TextStyle(
              fontSize: 16,
              color: _isDarkMode ? ColorStyle.white : ColorStyle.black),
        ),
        backgroundColor:
            _isDarkMode ? ColorStyle.lightPrimary : ColorStyle.darkPrimary,
      ),
      body: PlaceDetail.favoriteProducts.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Kamu Belum Mempunyai Tempat Favorit :(',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: _isDarkMode
                              ? ColorStyle.primary
                              : ColorStyle.black),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: PlaceDetail.favoriteProducts.length,
              itemBuilder: (context, index) {
                var product = PlaceDetail.favoriteProducts[index];
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.address),
                  onTap: () {
                    // Implement navigation to product detail if needed
                  },
                );
              },
            ),
    );
  }
}
