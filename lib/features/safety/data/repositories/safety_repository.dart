import '../../domain/entities/emergency_contact.dart';

/// Repository de sécurité (mock).
abstract class SafetyRepository {
  Future<List<EmergencyContact>> getEmergencyContacts();
  Future<void> addEmergencyContact(EmergencyContact contact);
  Future<void> removeEmergencyContact(String id);

  /// Déclenche une alerte SOS : envoie position + alerte aux contacts.
  Future<void> triggerSos();

  /// Génère un lien de partage de trajet.
  Future<String> createTripSharingLink(List<String> contactIds);
}

class MockSafetyRepository implements SafetyRepository {
  MockSafetyRepository();

  final List<EmergencyContact> _contacts = [
    const EmergencyContact(
      id: 'c1',
      firstName: 'Marie',
      lastName: 'B.',
      phoneNumber: '+225 07 12 34 56 78',
      isPrimary: true,
    ),
    const EmergencyContact(
      id: 'c2',
      firstName: 'Thomas',
      lastName: 'D.',
      phoneNumber: '+225 05 98 76 54 32',
    ),
    const EmergencyContact(
      id: 'c3',
      firstName: 'Sophie',
      lastName: 'M.',
      phoneNumber: '+225 01 23 45 67 89',
    ),
  ];

  @override
  Future<List<EmergencyContact>> getEmergencyContacts() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_contacts);
  }

  @override
  Future<void> addEmergencyContact(EmergencyContact contact) async {
    _contacts.add(contact);
  }

  @override
  Future<void> removeEmergencyContact(String id) async {
    _contacts.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> triggerSos() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // Mock : on ne fait rien, mais on pourrait appeler des services
    // d'urgence, envoyer la position GPS, etc.
  }

  @override
  Future<String> createTripSharingLink(List<String> contactIds) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final token = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    return 'https://luxora.app/t/$token';
  }
}
