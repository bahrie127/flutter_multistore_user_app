import 'package:bloc/bloc.dart';
import 'package:flutter_fic7_app/data/models/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddToCart>((event, emit) {
      final productQuantity = ProductQuantity(
        product: event.product,
        quantity: event.quantity,
      );
      final currentState = state as _Loaded;
      emit(_Loaded([
        ...currentState.products,
        productQuantity,
      ]));
    });
  }
}
