import 'package:flutter/material.dart';

/// [BAGIAN 2.11 W4S2 - STACK + POSITIONED]
/// Ikon keranjang dengan badge angka merah di pojok kanan atas.
class CartBadge extends StatelessWidget {
  final int jumlah;
  final VoidCallback onPressed;

  const CartBadge({super.key, required this.jumlah, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Keranjang',
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.shopping_cart, size: 28),
          if (jumlah > 0)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                ), // BoxDecoration
                child: Text(
                  jumlah > 99 ? '99+' : '$jumlah',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ), // TextStyle
                ), // Text
              ), // Container
            ), // Positioned
        ],
      ), // Stack
    ); // IconButton
  }
}
