import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';
import 'package:nike/features/shipping/domain/usecases/get_checkout_usecase.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetCheckoutUseCase _getCheckoutUseCase;
  CheckoutBloc(this._getCheckoutUseCase) : super(CheckoutInitial()) {
    on<CheckoutStarted>((event, emit) async {
      try {
        emit(CheckoutLoading());
        final result = await _getCheckoutUseCase(event.orderId);
        emit(CheckoutLoaded(result));
      } catch (e) {
        emit(CheckoutError(AppException()));
      }
    });
  }
}
