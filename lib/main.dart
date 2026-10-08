import 'package:flutter/material.dart';
 
import 'pages/main_page.dart';
 
void main() {
  runApp(const KatalogApp());
}
 
/// Widget akar aplikasi: mengatur judul, tema, dan halaman pertama.
class KatalogApp extends StatelessWidget {
  const KatalogApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Produk',
      debugShowCheckedModeBanner: false,
      theme: _buatTema(),
      home: const MainPage(),
    ); // MaterialApp
  }
 
  /// Tema dipisah supaya build() tetap singkat dan mudah dibaca.
  ThemeData _buatTema() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      appBarTheme: const AppBarTheme(centerTitle: true),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ), // SnackBarThemeData
    ); // ThemeData
  }
}

