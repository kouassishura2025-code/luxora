import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/fleet_repository.dart';
import '../../domain/entities/fleet_vehicle.dart';

final fleetRepositoryProvider = Provider<FleetRepository>((ref) {
  return MockFleetRepository();
});

final fleetVehiclesProvider = Provider<List<FleetVehicle>>((ref) {
  return ref.watch(fleetRepositoryProvider).getVehicles();
});

final fleetVehicleByIdProvider =
    Provider.family<FleetVehicle?, String>((ref, id) {
  return ref.watch(fleetRepositoryProvider).getVehicleById(id);
});
