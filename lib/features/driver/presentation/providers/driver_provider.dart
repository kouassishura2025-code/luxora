import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/driver_repository.dart';
import '../../domain/entities/driver.dart';

@immutable
class FavoriteDriversState {
  const FavoriteDriversState({
    this.drivers = const [],
    this.removingIds = const {},
  });

  final List<Driver> drivers;
  final Set<String> removingIds;

  FavoriteDriversState copyWith({
    List<Driver>? drivers,
    Set<String>? removingIds,
  }) {
    return FavoriteDriversState(
      drivers: drivers ?? this.drivers,
      removingIds: removingIds ?? this.removingIds,
    );
  }
}

class FavoriteDriversNotifier extends StateNotifier<FavoriteDriversState> {
  FavoriteDriversNotifier(this._repository)
      : super(const FavoriteDriversState()) {
    _load();
  }

  final DriverRepository _repository;

  void _load() {
    state = state.copyWith(
      drivers: _repository.getFavoriteDrivers(),
    );
  }

  Future<void> removeFavorite(String driverId) async {
    state = state.copyWith(
      removingIds: {...state.removingIds, driverId},
    );

    await Future<void>.delayed(const Duration(milliseconds: 600));

    state = FavoriteDriversState(
      drivers: state.drivers.where((d) => d.id != driverId).toList(),
      removingIds: state.removingIds.difference({driverId}),
    );
  }

  Future<void> addBackFavorite(Driver driver) async {
    if (state.drivers.any((d) => d.id == driver.id)) return;
    state = state.copyWith(
      drivers: [...state.drivers, driver.copyWith(isFavorite: true)],
    );
  }
}

final driverRepositoryProvider = Provider<DriverRepository>((ref) {
  return MockDriverRepository();
});

final favoriteDriversProvider = StateNotifierProvider<
    FavoriteDriversNotifier, FavoriteDriversState>((ref) {
  return FavoriteDriversNotifier(ref.watch(driverRepositoryProvider));
});
