part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addToCart(Product product, int quantity) =
      _AddToCart;
  const factory CheckoutEvent.removeToCart(Product product, int quantity) =
      _RemoveToCart;

      const factory CheckoutEvent.clear() = _Clear;
}
