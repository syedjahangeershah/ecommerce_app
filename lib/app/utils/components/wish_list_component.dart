import 'package:flutter/material.dart';

class WishListComponent extends StatelessWidget {
  const WishListComponent({super.key, required this.onTap, this.color});
  final void Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.3),
          border: Border.all(width: .8, color: Colors.black),
        ),
        child: Center(
          child: Icon(Icons.favorite, color: color),
        ),
      ),
    );
  }
}
