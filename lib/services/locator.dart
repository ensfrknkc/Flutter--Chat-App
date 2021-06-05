import 'package:get_it/get_it.dart';
import 'package:kbu_app/repository/user_repository.dart';
import 'package:kbu_app/services/notificationSendService.dart';
import 'package:kbu_app/services/firebase_storage_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_db_service.dart';

GetIt locator = GetIt();

void setupLocator(){
locator.registerLazySingleton(() => FirebaseAuthService());
locator.registerLazySingleton(() => UserRepository());
locator.registerLazySingleton(() => FireStoreDbService());
locator.registerLazySingleton(() => FirebaseStorageService());
locator.registerLazySingleton(() => NotificationSendService());

}