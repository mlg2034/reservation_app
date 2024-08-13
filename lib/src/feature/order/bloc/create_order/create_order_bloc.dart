import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/order/data/order_repository.dart';
import 'package:paloma_test_app/src/feature/order/params/create_order_params.dart';

part 'create_order_events.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final OrderRepository _orderRepository;

  CreateOrderBloc(this._orderRepository) : super(CreateOrderInitial()) {
   on<CreateOrder>(_createOrder);
  }

  Future<void> _createOrder(
      CreateOrder event, Emitter<CreateOrderState> emit) async {
    if (state is CreateOrderLoading) return;
    emit(CreateOrderLoading());
    try {
      await _orderRepository.createOrder(event.params);
      emit(CreateOrderSuccess());
    } catch (error) {
      emit(
        CreateOrderError(error: error.toString()),
      );
      print(error);
    }
  }
}
