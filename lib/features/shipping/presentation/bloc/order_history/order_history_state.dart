part of 'order_history_bloc.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryBlocInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderHistoryEntity> orders;

  const OrderHistoryLoaded({required this.orders});
}

class OrderHistoryError extends OrderHistoryState {
  final AppException exception;

  const OrderHistoryError({required this.exception});
}
