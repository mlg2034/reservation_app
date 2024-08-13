part of 'create_order_bloc.dart';
sealed class CreateOrderEvent{}

final class CreateOrder extends CreateOrderEvent{
  final CreateOrderParams params;
  CreateOrder({
    required this.params
  });
}