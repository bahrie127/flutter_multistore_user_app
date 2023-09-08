import 'package:flutter/material.dart';

import '../../../utils/images.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final int? productId;
  const FavouriteButton(
      {Key? key,
      this.backgroundColor = Colors.black,
      this.favColor = Colors.white,
      this.isSelected = false,
      this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            Images.wishlist,
            color: favColor,
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
