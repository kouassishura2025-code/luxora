import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// Instance globale de GetIt.
final GetIt sl = GetIt.instance;

/// Enregistre tous les services partagés au démarrage.
///
/// Note : l'auth passe par Riverpod (`authRepositoryProvider`),
/// ce container sert pour les services transverses (Dio, Storage…).
Future<void> init() async {
  // ─── Réseau ─────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    );
    return dio;
  });

  // ─── Features ────────────────────────────────────────────
  // À enregistrer au fur et à mesure :
  // await initAuthFeature();
  // await initBookingFeature();
}
