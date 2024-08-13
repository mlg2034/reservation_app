import 'package:flutter/material.dart';
import 'package:paloma_test_app/core/route/app_router.dart';
import 'package:paloma_test_app/src/feature/main/bloc/multi_bloc_wrapper.dart';

class AppScreen extends StatelessWidget {
   AppScreen({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
      ),
    );
  }
}