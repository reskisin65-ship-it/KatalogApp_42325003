import 'package:flutter/material.dart';


class ProfilPage extends StatelessWidget {
  final int jumlahProduk;
  final int jumlahKeranjang;

  const ProfilPage({
    super.key,
    required this.jumlahProduk,
    required this.jumlahKeranjang,
  });

  static const String _nama = 'Reski Putra Sinaga';
  static const String _nim = '42325003';

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: warna.primaryContainer,
              child: Icon(Icons.person, size: 56, color: warna.primary),
            ), // CircleAvatar
            const SizedBox(height: 16),
            const Text(
              _nama,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ), // Text
            const Text(_nim, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _statKartu(context, 'Produk', '$jumlahProduk', Icons.inventory_2)),
                const SizedBox(width: 12),
                Expanded(child: _statKartu(context, 'Keranjang', '$jumlahKeranjang', Icons.shopping_cart)),
              ],
            ), // Row
          ],
        ), // Column
      ), // Padding
    ); // Center
  }

  Widget _statKartu(BuildContext context, String label, String nilai, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ), // BoxDecoration
      child: Column(
        children: [
          Icon(ikon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(nilai, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ), // Column
    ); // Container
  }
}
