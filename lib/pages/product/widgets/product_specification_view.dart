import 'dart:io';

import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';
import '../../base_widgets/title_row.dart';

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  const ProductSpecification({Key? key, required this.productSpecification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleRow(
          title: 'Spesification',
          isDetailsPage: true,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        productSpecification.isNotEmpty
            ? Expanded(child: Text(productSpecification))
            : const Center(child: Text('No specification')),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}
