import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Résultat de recherche d'adresse.
class GeocodingResult {
  const GeocodingResult({
    required this.label,
    required this.latLng,
  });

  final String label;
  final LatLng latLng;
}

/// Service de géocodage OpenStreetMap (Nominatim).
///
/// Gratuit, sans clé API. Limité à 1 req/sec.
class GeocodingService {
  GeocodingService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://nominatim.openstreetmap.org';
  static const _userAgent = 'LUXORA/0.1 (contact@luxora.app)';

  /// Recherche d'adresses correspondant à la requête.
  Future<List<GeocodingResult>> search(String query) async {
    if (query.trim().length < 3) return [];

    try {
      final uri = Uri.parse('$_baseUrl/search').replace(
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': '6',
          'addressdetails': '1',
        },
      );

      final response = await _client.get(
        uri,
        headers: {'User-Agent': _userAgent},
      );

      if (response.statusCode != 200) return [];

      final List data = jsonDecode(response.body) as List;
      return data.map((item) {
        final map = item as Map<String, dynamic>;
        return GeocodingResult(
          label: map['display_name'] as String? ?? '',
          latLng: LatLng(
            double.parse(map['lat'] as String),
            double.parse(map['lon'] as String),
          ),
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
