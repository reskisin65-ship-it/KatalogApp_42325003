import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/produk.dart';

/// [TUGAS 4 - FORM TAMBAH PRODUK] (Bagian 3: Form + validasi)
/// Berisi 2 kolom (nama, harga). Jika valid, halaman ditutup dan
/// mengembalikan objek Produk baru lewat Navigator.pop (Bagian 4.2).
class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _simpan() {
    // validate() menjalankan semua validator; true jika semua lolos
    if (_formKey.currentState!.validate()) {
      final produkBaru = Produk(
        id: DateTime.now().millisecondsSinceEpoch,
        nama: _namaController.text.trim(),
        harga: int.parse(_hargaController.text),
      );
      Navigator.pop(context, produkBaru); // kirim data balik
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label_outline),
                ), // InputDecoration
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama produk wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama produk minimal 3 karakter';
                  }
                  return null;
                },
              ), // TextFormField
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payments_outlined),
                ), // InputDecoration
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  final angka = int.tryParse(value);
                  if (angka == null) return 'Harga harus berupa angka';
                  if (angka <= 0) return 'Harga harus lebih dari 0';
                  return null;
                },
              ), // TextFormField
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpan,
                  child: const Text('Simpan Produk'),
                ), // ElevatedButton
              ), // SizedBox
            ],
          ), // Column
        ), // Form
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
