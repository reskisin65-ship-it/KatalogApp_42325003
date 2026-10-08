import 'package:flutter/material.dart';

import '../models/produk.dart';

/// [TUGAS 2 - HALAMAN DETAIL PRODUK]
/// Menerima data lewat constructor (Bagian 4.1), menampilkan nama, harga,
/// ikon, dan tombol "Tambah ke Keranjang".
class ProdukDetailPage extends StatefulWidget {
  final Produk produk;

  /// Dipanggil saat tombol ditekan; MainPage yang menambah jumlah keranjang.
  final VoidCallback onTambahKeranjang;

  const ProdukDetailPage({
    super.key,
    required this.produk,
    required this.onTambahKeranjang,
  });

  @override
  State<ProdukDetailPage> createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  // State lokal: berapa kali produk ini ditambahkan dari halaman ini.
  int _ditambahkan = 0;

  void _tambah() {
    widget.onTambahKeranjang(); // update badge di MainPage
    setState(() {
      _ditambahkan++; // update tampilan halaman ini
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${widget.produk.nama} ditambahkan ke keranjang')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final p = widget.produk;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: warna.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ), // BoxDecoration
                child: Icon(p.ikon, size: 96, color: warna.primary),
              ), // Container
            ), // Center
            const SizedBox(height: 24),
            Text(
              p.nama,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ), // Text
            const SizedBox(height: 8),
            Text(
              formatRupiah(p.harga),
              style: TextStyle(fontSize: 20, color: warna.primary),
            ), // Text
            const SizedBox(height: 16),
            Text(
              _ditambahkan == 0
                  ? 'Belum ditambahkan dari halaman ini.'
                  : 'Ditambahkan dari halaman ini: $_ditambahkan kali',
              style: const TextStyle(color: Colors.grey),
            ), // Text
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambah,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ), // ElevatedButton.icon
            ), // SizedBox
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}
