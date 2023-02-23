import 'package:get_it/get_it.dart';

import '../../boilerplate/pagination/cubits/pagination_cubit.dart';

class ServiceLocator {
  static void registerModels() {
    GetIt.I.registerLazySingleton<CubitStore>(() => CubitStore());
  }

  static refreshCalls() {
    GetIt.I<CubitStore>().calls!.getList();
  }

  static setCalls(PaginationCubit appointments) {
    GetIt.I<CubitStore>().calls = appointments;
  }
}

class CubitStore {
  PaginationCubit? calls;
}
