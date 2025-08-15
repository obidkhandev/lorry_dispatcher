import 'package:lorry_dispatcher/core/api/dio_client.dart';
import 'package:lorry_dispatcher/features/common/bloc/auth/auth_bloc.dart';
import 'package:lorry_dispatcher/features/common/bloc/main_tab/main_tab_cubit.dart';
import 'package:lorry_dispatcher/features/common/bloc/settings/settings_cubit.dart';
import 'package:lorry_dispatcher/features/common/data/datasource/auth_datasource.dart';
import 'package:lorry_dispatcher/features/common/data/repository/auth.dart';
import 'package:lorry_dispatcher/features/common/data/repository/settings.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/auth.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/get_app_lang.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/get_app_onboard.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/save_app_onboard.dart';
import 'package:lorry_dispatcher/features/common/domain/uscase/settings/set_app_lang.dart';
import 'package:lorry_dispatcher/features/create_order/data/datasource/order_create_datasource.dart';
import 'package:lorry_dispatcher/features/create_order/data/repository/order_create_repository_impl.dart';
import 'package:lorry_dispatcher/features/create_order/domain/repository/order_create_repository.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/create_order_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> initDi() async {
  // 1. SharedPreferences
  final SharedPreferences pref = await SharedPreferences.getInstance();
  inject.registerSingleton<SharedPreferences>(pref);

  inject.registerSingleton<DioClient>(DioClient(pref));

  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

void _dataSources() {
  inject.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(inject(), inject()),
  );

  inject.registerLazySingleton<OrderCreateDatasource>(
    () => OrderCreateDatasourceImpl(inject()),
  );
}

void _repositories() {
  // Auth
  inject.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(inject(), inject()),
  );
  // Order
  inject.registerLazySingleton<OrderCreateRepository>(
    () => OrderCreateRepositoryImpl(inject()),
  );

  // Settings
  inject.registerLazySingleton<ISettingRepository>(
    () => SettingRepository(inject()),
  );
}

void _useCase() {
  // Language
  inject.registerLazySingleton(() => GetAppLangUseCase(inject()));
  inject.registerLazySingleton(() => SetAppLangUseCase(inject()));
  inject.registerLazySingleton(() => SetAppOnboardUseCase(inject()));
  inject.registerLazySingleton(() => GetAppOnboardUseCase(inject()));
}

void _cubit() {
  // AUTH

  inject.registerFactory(() => MainTabCubit());
  inject.registerFactory(() => AuthBloc(inject()));

  inject.registerFactory(() => CreateOrderBloc(inject()));

  // Language
  inject.registerLazySingleton(
    () => SettingsCubit(inject(), inject(), inject(), inject(), inject()),
  );
}
