import 'package:get_it/get_it.dart';
import 'package:paloma_test_app/core/db/database_service';
import 'package:paloma_test_app/src/feature/order/bloc/get_order_list/order_list_bloc.dart';
import 'package:paloma_test_app/src/feature/order/data/order_repository.dart';
import 'package:paloma_test_app/src/feature/product/bloc/product_list_bloc_bloc.dart';
import 'package:paloma_test_app/src/feature/product/data/product_repository.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_detail_bloc/table_detail_bloc.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_list_bloc/table_list_bloc.dart';
import 'package:paloma_test_app/src/feature/table/data/table_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  //Repositories
  sl.registerLazySingleton(
    () => DatabaseService(),
  );
  sl.registerLazySingleton(
    () => TableRepository(sl()),
  );
  sl.registerLazySingleton(
    () => ProductRepository(sl()),
  );
  sl.registerLazySingleton(
    () => OrderRepository(sl()),
  );
  //BLoC
  sl.registerLazySingleton(
    () => ProductListBloc(sl()),
  );
  sl.registerLazySingleton(
    () => TableListBloc(sl()),
  );
  sl.registerLazySingleton(
    () => TableDetailBloc(sl()),
  );
   sl.registerLazySingleton(
    () => OrderListBloc(sl()),
  );
}
