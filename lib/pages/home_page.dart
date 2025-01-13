// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:game_store/components/carousel/carousel.dart';
import 'package:game_store/components/appbar/custom_appbar.dart';
import 'package:game_store/components/categories/categories.dart';
import 'package:game_store/components/products/products_list_grid.dart';
import 'package:game_store/database/database_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString('userEmail') ?? '';

      if (userEmail.isNotEmpty) {
        final dbHelper = DatabaseHelper();
        final userData = await dbHelper.getUserByEmail(userEmail);

        if (userData != null) {
          setState(() {
            _userName = userData['name'] ?? 'User';
          });
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const CustomAppbar(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Hello",
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _userName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Carousel(),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 20),
                const SizedBox(height: 400, child: ProductGrid()),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
