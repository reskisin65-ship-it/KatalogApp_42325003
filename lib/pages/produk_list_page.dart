import 'package:flutter/material.dart';

import '../models/produk.dart';
import '../widgets/product_card.dart';

/// [TUGAS 1 - HALAMAN DAFTAR PRODUK]
/// Menampilkan produk dalam GridView memakai ProductCard buatan sendiri.
/// Halaman ini hanya menampilkan data; state-nya dipegang oleh MainPage.
class ProdukListPage extends StatelessWidget {
  final List<Produk> produk;
  final void Function(Produk) onTapProduk;
  final void Function(Produk) onHapusProduk;

  const ProdukListPage({
    super.key,
    required this.produk,
    required this.onTapProduk,
    required this.onHapusProduk,
  });

  @override
  Widget build(BuildContext context) {
    if (produk.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('Belum ada produk. Tekan "Tambah Produk".'),
          ],
        ), // Column
      ); // Center
    }

    return GridView.builder(
      // padding bawah besar supaya kartu terakhir tidak tertutup tombol (FAB)
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
      itemCount: produk.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ), // SliverGridDelegateWithFixedCrossAxisCount
      itemBuilder: (context, index) {
        final item = produk[index];
        return ProductCard(
          produk: item,
          onTap: () => onTapProduk(item),
          onDelete: () => onHapusProduk(item),
        ); // ProductCard
      },
    ); // GridView.builder
  }
}
