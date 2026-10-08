import 'package:flutter/material.dart';

import '../models/produk.dart';

/// [BAGIAN 7 - WIDGET KUSTOM / REUSABLE WIDGET]
/// Kartu produk yang dipakai berulang di halaman daftar.
/// Data dan aksi dikirim lewat parameter constructor.
class ProductCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.produk,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ), // BoxDecoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: warna.primaryContainer,
                  child: Icon(produk.ikon, size: 30, color: warna.primary),
                ), // CircleAvatar
                // Tombol hapus -> memicu AlertDialog konfirmasi di MainPage
                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Hapus produk',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ), // IconButton
              ],
            ), // Row
            const Spacer(),
            Text(
              produk.nama,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ), // Text
            const SizedBox(height: 4),
            Text(
              formatRupiah(produk.harga),
              style: const TextStyle(color: Colors.grey),
            ), // Text
          ],
        ), // Column
      ), // Container
    ); // GestureDetector
  }
}
