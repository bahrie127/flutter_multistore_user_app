import 'package:flutter/material.dart';

import 'package:flutter_fic7_app/data/models/products_response_model.dart';

import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import 'widgets/bottom_cart_view.dart';
import 'widgets/product_image_view.dart';
import 'widgets/product_specification_view.dart';
import 'widgets/product_title_view.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).cardColor, size: 20),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text('Product Detail',
                  style: robotoRegular.copyWith(
                      fontSize: 20, color: Theme.of(context).cardColor)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProductImageView(
                      image: widget.product.imageProduct!,
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                      padding: const EdgeInsets.only(
                          top: Dimensions.fontSizeDefault),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                Dimensions.paddingSizeExtraLarge),
                            topRight: Radius.circular(
                                Dimensions.paddingSizeExtraLarge)),
                      ),
                      child: Column(
                        children: [
                          ProductTitleView(
                            product: widget.product,
                          ),
                          Container(
                            height: 250,
                            margin: const EdgeInsets.only(
                                top: Dimensions.paddingSizeSmall),
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeSmall),
                            child: ProductSpecification(
                                productSpecification:
                                    widget.product.descripton!),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          bottomNavigationBar: BottomCartView(
            product: widget.product,
          )),
    );
  }
}
