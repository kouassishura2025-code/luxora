import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../foundations/colors/luxora_colors.dart';

/// Carte signature LUXORA — OpenStreetMap en thème dark.
///
/// Aucune clé API, aucun coût. Fond CartoDB Dark Matter.
class LuxoraMap extends StatelessWidget {
  const LuxoraMap({
    super.key,
    required this.center,
    this.initialZoom = 14,
    this.markers = const [],
    this.polylines = const [],
    this.onTap,
    this.interactive = true,
    this.showAttribution = true,
    this.borderRadius,
  });

  final LatLng center;
  final double initialZoom;
  final List<Marker> markers;
  final List<Polyline> polylines;
  final void Function(TapPosition, LatLng)? onTap;
  final bool interactive;
  final bool showAttribution;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final map = FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: initialZoom,
        onTap: onTap,
        interactionOptions: InteractionOptions(
          flags: interactive
              ? InteractiveFlag.all & ~InteractiveFlag.rotate
              : InteractiveFlag.none,
        ),
      ),
      children: [
        // ─── Fond de carte dark ────────────────────────────
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.luxora.luxora',
          tileProvider: NetworkTileProvider(),
        ),

        // ─── Itinéraires ───────────────────────────────────
        if (polylines.isNotEmpty)
          PolylineLayer(polylines: polylines),

        // ─── Marqueurs ─────────────────────────────────────
        if (markers.isNotEmpty) MarkerLayer(markers: markers),

        // ─── Attribution OSM (obligatoire légalement) ──────
        if (showAttribution)
          RichAttributionWidget(
            alignment: AttributionAlignment.bottomLeft,
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap',
                onTap: () {},
              ),
              TextSourceAttribution(
                'CARTO',
                onTap: () {},
              ),
            ],
          ),
      ],
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: map);
    }
    return map;
  }
}

/// Marqueur doré LUXORA pour une position.
class LuxoraMapMarker extends StatelessWidget {
  const LuxoraMapMarker({
    super.key,
    this.icon = Icons.location_on_rounded,
    this.isPrimary = true,
    this.size = 40,
  });

  final IconData icon;
  final bool isPrimary;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = isPrimary
        ? LuxoraColors.champagne
        : LuxoraColors.textPrimary;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: LuxoraColors.obsidian, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: LuxoraColors.obsidian,
      ),
    );
  }
}
