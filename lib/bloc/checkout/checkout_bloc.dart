import 'package:bloc/bloc.dart';
import 'package:flutter_fic7_app/data/models/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddToCart>((event, emit) {
      final currentState = state as _Loaded;
      final productQuantity = ProductQuantity(
        product: event.product,
        quantity: event.quantity,
      );

      // list of productquatity A
      // productquantity B

      // kalau B ada di A maka update quantity, bila B tidak ada di A maka add B to A
      if (currentState.products
          .where((element) => element.product == event.product)
          .isNotEmpty) {
        for (var productQuantity in currentState.products) {
          if (productQuantity.product == event.product) {
            productQuantity.quantity =
                productQuantity.quantity + event.quantity;
          }
        }
        final newState = currentState.products;
        emit(const _Loading());
        emit(_Loaded(newState));
      } else {
        emit(_Loaded([
          ...currentState.products,
          productQuantity,
        ]));
      }

      // currentState.products.firstWhere(
      //   (element) => element.product == event.product,
      // );

      // emit(_Loaded([
      //   ...currentState.products,
      //   productQuantity,
      // ]));
    });
  }
}
