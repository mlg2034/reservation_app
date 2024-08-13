import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/order/data/order_repository.dart';
import 'package:paloma_test_app/src/feature/order/model/order_model.dart';

part 'order_list_events.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final OrderRepository _orderRepository;
  OrderListBloc(this._orderRepository) : super(OrderListInitial()) {
    on<GetOrderList>(_getOrderList);
  }

  Future<void> _getOrderList(
      GetOrderList event, Emitter<OrderListState> emit) async {
    emit(OrderListLoading());
    try {
      final result = await _orderRepository.getAllOrders();
      emit(
        OrderListSuccess(orderList: result),
      );
    } catch (error) {
      emit(
        OrderListError(error: error.toString()),
      );
    }
  }
}
