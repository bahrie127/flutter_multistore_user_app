import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fic7_app/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_fic7_app/utils/price_ext.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../product/product_detail.dart';

class CartWidget extends StatelessWidget {
  final ProductQuantity productQuantity;
  const CartWidget({
    Key? key,
    required this.productQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //       transitionDuration: const Duration(milliseconds: 1000),
        //       pageBuilder: (context, anim1, anim2) => const ProductDetail(),
        //     ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(.20),
                        width: 1)),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    height: 60,
                    width: 60,
                    image: productQuantity.product.imageProduct!,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(productQuantity.product.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titilliumBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: ColorResources.getReviewRattingColor(
                                      context),
                                )),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeSmall,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CheckoutBloc>().add(
                                    CheckoutEvent.removeToCart(
                                        productQuantity.product,
                                        productQuantity.quantity),
                                  );
                            },
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  Images.delete,
                                  scale: .5,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            '${productQuantity.product.price}'.formatPrice(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titilliumRegular.copyWith(
                                color: ColorResources.getPrimary(context),
                                fontSize: Dimensions.fontSizeExtraLarge),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(' x ${productQuantity.quantity}'),
                        ],
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
