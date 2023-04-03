

import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:exam_demo_app/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! blocs
  sl.registerFactory(() => AuthProvider(authRepository: sl()));
  

  //! repositories
  sl.registerLazySingleton<AuthRipository>(() =>
      AuthRepositoryImp());

 /*  sl.registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImpl(adsDataSource: sl(), networkInfo: sl())); */
 
  //! dataSources
 /*  sl.registerLazySingleton<ServicesDataSource>(
      () => ServicesDataSourceImpl(/* client: sl() */));
  sl.registerLazySingleton<AdsDataSource>(
      () => AdsDataSourceImpl(/* client: sl() */));
  sl.registerLazySingleton<NewsDataSource>(
      () => NewsDataSourceImpl(/* client: sl() */)); */

  /* //! core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => LocalStorage(prefs: sl()));
 */
  
}
