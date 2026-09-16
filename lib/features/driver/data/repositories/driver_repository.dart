import '../../domain/entities/driver.dart';

/// Repository chauffeurs favoris (mock).
abstract class DriverRepository {
  List<Driver> getFavoriteDrivers();
  List<Driver> getAllDrivers();
  Driver? getDriverById(String id);
}

class MockDriverRepository implements DriverRepository {
  static const _drivers = <Driver>[
    Driver(
      id: 'alexandre',
      firstName: 'Alexandre',
      lastName: 'L.',
      rating: 4.98,
      tripCount: 1247,
      yearsOfService: 5,
      vehicleModel: 'Mercedes Classe S',
      status: DriverStatus.available,
      isFavorite: true,
      languages: ['Français', 'Anglais', 'Espagnol'],
    ),
    Driver(
      id: 'marie',
      firstName: 'Marie',
      lastName: 'B.',
      rating: 4.99,
      tripCount: 892,
      yearsOfService: 3,
      vehicleModel: 'Range Rover Velar',
      status: DriverStatus.available,
      isFavorite: true,
      languages: ['Français', 'Anglais'],
    ),
    Driver(
      id: 'thomas',
      firstName: 'Thomas',
      lastName: 'D.',
      rating: 4.97,
      tripCount: 2158,
      yearsOfService: 8,
      vehicleModel: 'Mercedes Classe E',
      status: DriverStatus.onRide,
      isFavorite: true,
      languages: ['Français'],
    ),
    Driver(
      id: 'sophie',
      firstName: 'Sophie',
      lastName: 'M.',
      rating: 4.96,
      tripCount: 654,
      yearsOfService: 2,
      vehicleModel: 'Mercedes Classe V',
      status: DriverStatus.offDuty,
      languages: ['Français', 'Anglais', 'Italien'],
    ),
  ];

  @override
  List<Driver> getFavoriteDrivers() =>
      _drivers.where((d) => d.isFavorite).toList();

  @override
  List<Driver> getAllDrivers() => _drivers;

  @override
  Driver? getDriverById(String id) {
    try {
      return _drivers.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }
}
