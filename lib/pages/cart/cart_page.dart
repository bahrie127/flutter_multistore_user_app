import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/utils/price_ext.dart';

import '../../bloc/checkout/checkout_bloc.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import '../base_widgets/custom_app_bar.dart';
import '../checkout/checkout_page.dart';
import 'widgets/cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<bool> chooseShipping = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
            vertical: Dimensions.paddingSizeDefault,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Center(
                    child: Row(
              children: [
                Text(
                  'Total Price ',
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return CircularProgressIndicator();
                      },
                      loaded: (products) {
                        int totalPrice = 0;
                        products.forEach(
                          (element) {
                            totalPrice +=
                                element.quantity * element.product.price!;
                          },
                        );
                        return Text(
                          '${totalPrice}'.formatPrice(),
                          style: titilliumSemiBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge),
                        );
                      },
                    );
                  },
                ),
              ],
            ))),
            Builder(
              builder: (context) => InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CheckoutPage();
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall,
                          vertical: Dimensions.fontSizeSmall),
                      child: Text('Checkout',
                          style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).cardColor,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ])),
      body: Column(children: [
        const CustomAppBar(title: 'Cart'),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: Text('No Data'),
                          );
                        },
                        loaded: (products) {
                          return ListView.builder(
                            itemCount: products.length,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimensions.paddingSizeSmall),
                                child: CartWidget(
                                  productQuantity: products[index],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
