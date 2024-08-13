part of 'order_list_bloc.dart';
sealed class  OrderListState{}

final class OrderListInitial extends OrderListState{}

final class OrderListLoading extends OrderListState{}

final class OrderListError extends OrderListState{
  final String error;
  OrderListError({
    required this.error
  });
}

final class OrderListSuccess extends OrderListState{
  final List<OrderModel> orderList;
  OrderListSuccess({
    required this.orderList
  });
}