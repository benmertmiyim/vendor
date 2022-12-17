
import 'package:get_it/get_it.dart';
import 'package:vendor/core/service/auth_service.dart';
import 'package:vendor/core/service/notification_service.dart';
import 'package:vendor/core/service/park_service.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/core/view/notification_view.dart';
import 'package:vendor/core/view/park_view.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthView());
  locator.registerLazySingleton(() => ParkService());
  locator.registerLazySingleton(() => ParkView());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => NotificationView());
}
