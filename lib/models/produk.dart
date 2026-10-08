import 'package:flutter/material.dart';

/// Data satu produk (mirip class Barang di modul OOP).
class Produk {
  final int id;
  final String nama;
  final int harga;
  final IconData ikon;

  const Produk({
    required this.id,
    required this.nama,
    required this.harga,
    this.ikon = Icons.inventory_2,
  });
}

/// 350000 -> "Rp 350.000"
String formatRupiah(int angka) {
  final s = angka.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}
