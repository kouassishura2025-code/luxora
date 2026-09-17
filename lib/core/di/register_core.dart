import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../firebase/firebase_auth_service.dart';
import '../firebase/firestore_service.dart';
import '../services/analytics_service.dart';
import '../services/crashlytics_service.dart';

/// Enregistre les services Core dans GetIt.
Future<void> registerCore(GetIt sl) async {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(sl()),
  );
  sl.registerLazySingleton<FirestoreService>(
    () => FirestoreService(sl()),
  );

  sl.registerLazySingleton<AnalyticsService>(
    () => AnalyticsService(),
  );
  sl.registerLazySingleton<CrashlyticsService>(
    () => CrashlyticsService(),
  );
}
