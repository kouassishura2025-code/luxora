import 'package:luxora/features/auth/domain/entities/user_entity.dart';
import 'package:luxora/features/booking/domain/entities/booking_entities.dart';
import 'package:luxora/features/fleet/domain/entities/fleet_vehicle.dart';
import 'package:luxora/features/driver/domain/entities/driver.dart';
import 'package:luxora/features/concierge/domain/entities/message.dart';
import 'package:luxora/features/notifications/domain/entities/app_notification.dart';
import 'package:flutter/material.dart';

/// Données de test LUXORA réutilisables.
abstract final class TestData {
  // ─── User ──────────────────────────────────────────────
  static const user = UserEntity(
    uid: 'test_uid_001',
    phoneNumber: '+2250700000000',
    displayName: 'Kouassi Shura',
    email: 'kouassi@luxora.app',
    kycVerified: true,
  );

  static const userNoKyc = UserEntity(
    uid: 'test_uid_002',
    phoneNumber: '+2250700000001',
    displayName: 'Invité',
    kycVerified: false,
  );

  // ─── Vehicle ───────────────────────────────────────────
  static const vehicle = VehicleClass(
    id: 'berline',
    name: 'Berline',
    tagline: 'L\'essentiel, sublimé.',
    description: 'Mercedes Classe E ou équivalent.',
    basePrice: 25,
    pricePerKm: 2.2,
    eta: 4,
    capacity: 3,
    icon: Icons.directions_car_filled_outlined,
    accent: Color(0xFF6B7C93),
  );

  // ─── Fleet Vehicle ─────────────────────────────────────
  static const fleetVehicle = FleetVehicle(
    id: 'test_suv',
    name: 'SUV',
    model: 'Range Rover Velar',
    tagline: 'L\'espace, sans compromis.',
    description: 'Test description.',
    basePrice: 38,
    pricePerKm: 3.1,
    capacity: 4,
    luggage: 4,
    eta: 6,
    icon: Icons.airport_shuttle_outlined,
    gradientColors: [Color(0xFF2A3A4A), Color(0xFF1A2A3A)],
    amenities: ['Wi-Fi', 'Climatisation'],
  );

  // ─── Driver ────────────────────────────────────────────
  static const driver = Driver(
    id: 'test_driver',
    firstName: 'Alexandre',
    lastName: 'L.',
    rating: 4.98,
    tripCount: 1247,
    yearsOfService: 5,
    vehicleModel: 'Mercedes Classe S',
    status: DriverStatus.available,
    isFavorite: true,
  );

  // ─── Message ───────────────────────────────────────────
  static final message = ConciergeMessage(
    id: 'msg_001',
    author: MessageAuthor.client,
    content: 'Bonjour',
    sentAt: DateTime(2026, 9, 15, 20, 45),
  );

  // ─── Notification ──────────────────────────────────────
  static final notification = AppNotification(
    id: 'notif_001',
    category: NotificationCategory.booking,
    title: 'Votre chauffeur arrive',
    body: 'Alexandre L. est à 2 min.',
    receivedAt: DateTime(2026, 9, 15, 20, 45),
  );
}
