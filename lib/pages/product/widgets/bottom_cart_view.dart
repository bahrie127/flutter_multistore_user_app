import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fic7_app/data/models/products_response_model.dart';

import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../base_widgets/show_custom_snakbar.dart';
import 'cart_bottom_sheet.dart';

class BottomCartView extends StatefulWidget {
  final Product product;
  const BottomCartView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<BottomCartView> createState() => _BottomCartViewState();
}

class _BottomCartViewState extends State<BottomCartView> {
  bool vacationIsOn = false;
  bool temporaryClose = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor,
              blurRadius: .5,
              spreadRadius: .1)
        ],
      ),
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Stack(children: [
                GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const CartPage()));
                    },
                    child: Image.asset(Images.cartArrowDownImage,
                        color: ColorResources.getPrimary(context))),
                Positioned(
                  top: 0,
                  right: 15,
                  child: Container(
                    height: 17,
                    width: 17,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.getPrimary(context),
                    ),
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        return state.map(
                          loaded: (value) {
                            int totalQty = 0;
                            value.products.forEach(
                              (element) {
                                totalQty += element.quantity;
                              },
                            );
                            return Text(
                              '$totalQty',
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: Theme.of(context).highlightColor),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ]),
            )),
        Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                if (vacationIsOn || temporaryClose) {
                } else {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0),
                      builder: (con) => CartBottomSheet(
                            product: widget.product,
                            callback: () {
                              showCustomSnackBar('Add to Cart', context,
                                  isError: false);
                            },
                          ));
                }
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.getPrimary(context),
                ),
                child: Text(
                  'Add to Cart',
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).highlightColor),
                ),
              ),
            )),
      ]),
    );
  }
}
