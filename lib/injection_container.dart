import 'package:ecom_clean_code/core/data/base_remote_data_source.dart';
import 'package:ecom_clean_code/features/login/data/datasource/login_remote_data_source.dart';
import 'package:ecom_clean_code/features/login/data/repository/login_repository_impl.dart';
import 'package:ecom_clean_code/features/login/domain/repository/login_repository.dart';
import 'package:ecom_clean_code/features/login/domain/usecase/login_user.dart';
import 'package:ecom_clean_code/features/login/presentation/blocs/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDi() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator
    ..registerFactory(() => Client())
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<BaseRemoteDataSource>(
        () => BaseRemoteDataSourceImpl(serviceLocator()))

    //Features
    //-------Login--------

    //Data sources
    ..registerLazySingleton<LoginRemoteDataSource>(
        () => LoginUserRemoteDataSourceImpl(serviceLocator()))

    //Repository
    ..registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
          loginRemoteDataSource: serviceLocator(),
        ))

    //Usecases
    ..registerLazySingleton(() => LoginUser(serviceLocator()))

    //Bloc
    ..registerFactory(() => LoginCubit(serviceLocator(), serviceLocator()));
}