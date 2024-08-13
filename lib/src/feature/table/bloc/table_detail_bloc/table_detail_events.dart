part of 'table_detail_bloc.dart';

sealed class TableDetailEvent {}

final class GetTableDetail extends TableDetailEvent {
  final int id;
  GetTableDetail({required this.id});
}
