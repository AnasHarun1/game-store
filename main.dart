import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main_screen.dart'; // Tambahkan ini

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(), // Tetap arahkan ke LoginPage sebagai halaman awal
  ));
}
