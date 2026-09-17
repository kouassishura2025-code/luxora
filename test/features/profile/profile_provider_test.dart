import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/profile/presentation/providers/profile_provider.dart';
import 'package:luxora/features/profile/domain/entities/user_profile.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() => container.dispose());

  group('ProfileProvider — état initial', () {
    test('profil défini par défaut', () {
      final state = container.read(profileProvider);
      expect(state.profile.firstName, 'Kouassi');
      expect(state.profile.lastName, 'Shura');
    });

    test('isSaving est false', () {
      expect(container.read(profileProvider).isSaving, isFalse);
    });

    test('erreur est null', () {
      expect(container.read(profileProvider).error, isNull);
    });

    test('memberTier est Silver par défaut', () {
      expect(
        container.read(profileProvider).profile.memberTier,
        MemberTier.silver,
      );
    });
  });

  group('updateProfile', () {
    test('met à jour le prénom', () async {
      await container
          .read(profileProvider.notifier)
          .updateProfile(firstName: 'Autre');
      expect(container.read(profileProvider).profile.firstName, 'Autre');
    });

    test('met à jour le nom', () async {
      await container
          .read(profileProvider.notifier)
          .updateProfile(lastName: 'Test');
      expect(container.read(profileProvider).profile.lastName, 'Test');
    });

    test('isSaving passe à true puis false', () async {
      final future = container
          .read(profileProvider.notifier)
          .updateProfile(firstName: 'Test');
      expect(container.read(profileProvider).isSaving, isTrue);
      await future;
      expect(container.read(profileProvider).isSaving, isFalse);
    });

    test('retourne true', () async {
      final result = await container
          .read(profileProvider.notifier)
          .updateProfile(firstName: 'Test');
      expect(result, isTrue);
    });
  });

  group('UserProfile', () {
    test('displayName combine prénom + nom', () {
      const profile = UserProfile(
        uid: 'uid',
        phoneNumber: '+225',
        firstName: 'Kouassi',
        lastName: 'Shura',
      );
      expect(profile.displayName, 'Kouassi Shura');
    });

    test('initials retourne 2 lettres', () {
      const profile = UserProfile(
        uid: 'uid',
        phoneNumber: '+225',
        firstName: 'Kouassi',
        lastName: 'Shura',
      );
      expect(profile.initials, 'KS');
    });

    test('displayName avec prénom manquant', () {
      const profile = UserProfile(
        uid: 'uid',
        phoneNumber: '+225',
        lastName: 'Shura',
      );
      expect(profile.displayName, 'Shura');
    });

    test('initials avec prénom manquant', () {
      const profile = UserProfile(
        uid: 'uid',
        phoneNumber: '+225',
        lastName: 'Shura',
      );
      expect(profile.initials, 'S');
    });

    test('displayName = "Invité" si tout est null', () {
      const profile = UserProfile(
        uid: 'uid',
        phoneNumber: '+225',
      );
      expect(profile.displayName, 'Invité');
    });
  });
}
