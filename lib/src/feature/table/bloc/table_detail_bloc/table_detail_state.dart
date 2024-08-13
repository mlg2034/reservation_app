part of 'table_detail_bloc.dart';

sealed class TableDetailState {}

final class TableDetailInitial extends TableDetailState {}

final class TableDetailLoading extends TableDetailState {}

final class TableDetailError extends TableDetailState {
  final String error;
  TableDetailError({required this.error});
}

final class TableDetailSuccess extends TableDetailState {
  final TableModel table;
  TableDetailSuccess({required this.table});
}
