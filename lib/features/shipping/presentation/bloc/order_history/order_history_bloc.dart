import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/shipping/domain/entity/order_history_entity.dart';
import 'package:nike/features/shipping/domain/usecases/get_order_history_usecase.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final GetOrderHistoryUseCase _getOrderHistoryUseCase;
  OrderHistoryBloc(this._getOrderHistoryUseCase) : super(OrderHistoryBlocInitial()) {
    on<OrderHistoryStarted>((event, emit) async {
      try {
        emit(OrderHistoryLoading());
        final orders = await _getOrderHistoryUseCase();
        emit(OrderHistoryLoaded(orders: orders));
      } catch (e) {
        emit(OrderHistoryError(exception: AppException()));
      }
    });
  }
}
