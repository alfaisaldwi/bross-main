import 'package:flutter/material.dart';
import 'package:bross_main/model/booking_model.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingHistoryPage extends StatefulWidget {
  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
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
    await Future.delayed(Duration(seconds: 3));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isDarkMode ? ColorStyle.darkBackground : ColorStyle.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Histori Booking',
          style: TextStyle(
              fontSize: 16,
              color: _isDarkMode ? ColorStyle.white : ColorStyle.black),
        ),
        backgroundColor:
            _isDarkMode ? ColorStyle.lightPrimary : ColorStyle.darkPrimary,
      ),
      body: BookingHistory.bookings.isEmpty
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
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Historimu masih Kosong :(',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: _isDarkMode
                                ? ColorStyle.primary
                                : ColorStyle.black),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: BookingHistory.bookings.length,
              itemBuilder: (context, index) {
                final booking = BookingHistory.bookings[index];
                return ListTile(
                  leading: Image.asset(
                    booking.image,
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(booking.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${booking.date.day}/${booking.date.month}/${booking.date.year}'),
                      Text('${booking.description}')
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BookingHistory.bookings.removeAt(index);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking dihapus dari histori'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
