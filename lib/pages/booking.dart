import 'package:flutter/material.dart';
import 'package:bross_main/model/booking_model.dart';
import 'package:bross_main/styles/color_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingPage extends StatefulWidget {
  final String image;
  final String name;

  const BookingPage({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late DateTime _selectedDate;
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadTheme();
  }

  late ThemeData _themeData;

  bool _isDarkMode = false;

  int _currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Booking ${widget.name}',
          style: TextStyle(
              fontSize: 16,
              color: _isDarkMode ? ColorStyle.white : ColorStyle.black),
        ),
        backgroundColor:
            _isDarkMode ? ColorStyle.lightPrimary : ColorStyle.darkPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            const Text('Pilih Tanggal'),
            ListTile(
              title: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            const Text('Deskripsi'),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Masukkan deskripsi booking',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Booking'),
                      content: const Text('Apakah Anda ingin melakukan booking?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                         
                            BookingHistory.addBooking(
                              Booking(
                                image: widget.image,
                                name: widget.name,
                                date: _selectedDate,
                                description: _descriptionController.text,
                              ),
                            );
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Booking'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
