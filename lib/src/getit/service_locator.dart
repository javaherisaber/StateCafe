import 'package:get_it/get_it.dart';
import 'package:state_cafe/data/repository.dart';
import 'package:state_cafe/src/getit/app/app_notifier.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Repository>(RepositoryImpl());
  getIt.registerSingleton<AppNotifier>(AppNotifier());
}
