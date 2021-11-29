import 'package:get_it/get_it.dart';

import '../app/data/repositories/poke_repo.dart';
import '../app/data/services/poke_service.dart';
import '../app/domain/interfaces/poke_interface.dart';
import '../app/domain/use_case/poke_usecase.dart';
import '../app/presentation/viewmodel/poke_viewmodel.dart';
import 'shared/http_service.dart';

void setupLocators() {
  /// Core
  GetIt.I.registerLazySingleton<HttpService>(() => HttpService());

  /// Service
  GetIt.I.registerLazySingleton<PokeService>(() => PokeService());

  /// Repository
  GetIt.I.registerLazySingleton<IPokeRepo>(() => PokeRepo(GetIt.I()));

  /// Use Case
  GetIt.I.registerLazySingleton<PokeUseCase>(() => PokeUseCase(GetIt.I()));

  /// ViewModel
  GetIt.I.registerLazySingleton<PokeViewModel>(() => PokeViewModel(GetIt.I()));
}
