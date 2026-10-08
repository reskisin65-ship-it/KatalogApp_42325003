import 'package:flutter/material.dart';

import '../models/produk.dart';
import '../widgets/cart_badge.dart';
import 'produk_detail_page.dart';
import 'produk_list_page.dart';
import 'profil_page.dart';
import 'tambah_produk_page.dart';

/// Halaman induk. Di sinilah SEMUA STATE aplikasi disimpan:
/// daftar produk, jumlah keranjang, dan tab yang aktif.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ---------- STATE ----------
  int _tabTerpilih = 0;
  int _jumlahKeranjang = 0;

  final List<Produk> _produk = [
    const Produk(id: 1, nama: 'Kursi Minimalis', harga: 350000, ikon: Icons.chair),
    const Produk(id: 2, nama: 'Meja Kerja Kayu', harga: 750000, ikon: Icons.table_restaurant),
    const Produk(id: 3, nama: 'Lampu Meja LED', harga: 120000, ikon: Icons.lightbulb),
    const Produk(id: 4, nama: 'Sofa Santai', harga: 2400000, ikon: Icons.weekend),
    const Produk(id: 5, nama: 'Tempat Tidur Single', harga: 1800000, ikon: Icons.bed),
    const Produk(id: 6, nama: 'Kulkas Mini', harga: 1500000, ikon: Icons.kitchen),
  ];

  // ---------- UMPAN BALIK ----------
  void _tampilkanSnackBar(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  // ---------- [BAGIAN 1] setState: jumlah keranjang ----------
  void _tambahKeKeranjang() {
    setState(() {
      _jumlahKeranjang++;
    });
  }

  // ---------- [BAGIAN 4.1] Navigasi + kirim data ke halaman detail ----------
  void _bukaDetail(Produk produk) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdukDetailPage(
          produk: produk,
          onTambahKeranjang: _tambahKeKeranjang,
        ),
      ), // MaterialPageRoute
    ); // Navigator.push
  }

  // ---------- [BAGIAN 3 + 4.2] Form tambah produk, ambil data balik ----------
  Future<void> _bukaTambahProduk() async {
    final Produk? produkBaru = await Navigator.push<Produk>(
      context,
      MaterialPageRoute(builder: (_) => const TambahProdukPage()),
    );

    if (produkBaru == null || !mounted) return; // pengguna menekan back

    setState(() {
      _produk.add(produkBaru);
    });
    _tampilkanSnackBar('Produk "${produkBaru.nama}" berhasil ditambahkan');
  }

  // ---------- [BAGIAN 5] AlertDialog konfirmasi hapus + SnackBar ----------
  Future<void> _konfirmasiHapus(Produk produk) async {
    final bool? yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Produk?'),
          content: Text('"${produk.nama}" akan dihapus dari daftar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ), // TextButton
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    ); // showDialog

    if (yakin != true || !mounted) return;

    setState(() {
      _produk.removeWhere((p) => p.id == produk.id);
    });
    _tampilkanSnackBar('Produk "${produk.nama}" berhasil dihapus');
  }

  void _bukaKeranjang() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keranjang'),
          content: Text(
            _jumlahKeranjang == 0
                ? 'Keranjang masih kosong.'
                : 'Jumlah item di keranjang: $_jumlahKeranjang',
          ),
          actions: [
            if (_jumlahKeranjang > 0)
              TextButton(
                onPressed: () {
                  setState(() {
                    _jumlahKeranjang = 0;
                  });
                  Navigator.pop(dialogContext);
                },
                child: const Text('Kosongkan'),
              ), // TextButton
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Tutup'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    ); // showDialog
  }

  // ---------- [BAGIAN 6] BottomNavigationBar ----------
  @override
  Widget build(BuildContext context) {
    final halaman = <Widget>[
      ProdukListPage(
        produk: _produk,
        onTapProduk: _bukaDetail,
        onHapusProduk: _konfirmasiHapus,
      ),
      ProfilPage(
        jumlahProduk: _produk.length,
        jumlahKeranjang: _jumlahKeranjang,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTerpilih == 0 ? 'Katalog Produk' : 'Profil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Badge jumlah keranjang di AppBar (Stack + Positioned)
          CartBadge(jumlah: _jumlahKeranjang, onPressed: _bukaKeranjang),
          const SizedBox(width: 8),
        ],
      ), // AppBar
      body: halaman[_tabTerpilih],
      floatingActionButton: _tabTerpilih == 0
          ? FloatingActionButton.extended(
              onPressed: _bukaTambahProduk,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Produk'),
            ) // FloatingActionButton.extended
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) {
          setState(() {
            _tabTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Produk'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ), // BottomNavigationBar
    ); // Scaffold
  }
}
