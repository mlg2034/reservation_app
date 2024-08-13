part of 'table_list_bloc.dart';

sealed class TableListState {}

final class TableListInitial extends TableListState{}
final class TableListLoading extends TableListState {}

final class TableListError extends TableListState {
  final String error;
  TableListError({required this.error});
}

final class TableListSuccess extends TableListState {
  final List<TableModel> tableList;
  TableListSuccess({required this.tableList});
}
