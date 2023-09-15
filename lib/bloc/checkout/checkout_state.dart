part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  // const factory CheckoutState.initial() = _Initial;

  const factory CheckoutState.loaded(List<ProductQuantity> products) = _Loaded;
  const factory CheckoutState.loading() = _Loading;
}

class ProductQuantity {
  final Product product;
  int quantity;
  ProductQuantity({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductQuantity &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
