import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

/// Position par défaut — Paris (Tour Eiffel).
/// Remplacée plus tard par geolocator.
final currentPositionProvider = Provider<LatLng>((ref) {
  return const LatLng(48.8584, 2.2945);
});

/// Zoom initial de la carte.
final mapZoomProvider = Provider<double>((ref) => 14.5);
