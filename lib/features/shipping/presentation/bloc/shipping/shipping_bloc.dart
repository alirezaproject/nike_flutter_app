import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';
import 'package:nike/features/shipping/domain/usecases/create_order_usecase.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final CreateOrderUseCase _createOrderUseCase;
  ShippingBloc(this._createOrderUseCase) : super(ShippingInitial()) {
    on<ShippingCreateOrder>((event, emit) async {
      try {
        emit(ShippingLoading());
        final result = await _createOrderUseCase(event.params);
        emit(ShippingLoaded(result: result));
      } catch (e) {
        emit(ShippingError(AppException()));
      }
    });
  }
}
