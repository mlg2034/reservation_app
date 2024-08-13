part of 'create_order_bloc.dart';

sealed class CreateOrderState{}

final class CreateOrderInitial extends CreateOrderState{}

final class CreateOrderLoading extends CreateOrderState{}

final class CreateOrderError extends CreateOrderState{
  final String error;
  CreateOrderError({
    required this.error
  });
}

final class CreateOrderSuccess extends CreateOrderState{
  
}