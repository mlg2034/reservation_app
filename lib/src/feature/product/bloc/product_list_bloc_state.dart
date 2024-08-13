part of 'product_list_bloc_bloc.dart';

sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListError extends ProductListState {
  final String error;
  ProductListError({required this.error});
}

final class ProductListSuccess extends ProductListState {
  final List<ProductModel> productList;
  ProductListSuccess({required this.productList});
}
