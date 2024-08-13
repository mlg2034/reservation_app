import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/product/data/product_repository.dart';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';

part 'product_list_bloc_events.dart';
part 'product_list_bloc_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository _productRepository;
  ProductListBloc(this._productRepository) : super(ProductListInitial()) {
    on<GetProductList>(_getProductList);
  }

  Future<void> _getProductList(
      GetProductList event, Emitter<ProductListState> emit) async {
    if (state is ProductListLoading) return;
    emit(ProductListLoading());
    try {
      final result =await _productRepository.getAllProducts();
      emit(ProductListSuccess(productList: result));
    } catch (error) {
      emit(
        ProductListError(error: error.toString()),
      );
    }
  }
}
