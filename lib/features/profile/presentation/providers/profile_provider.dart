import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_profile.dart';

/// État du profil (mock, en attendant Firestore).
@immutable
class ProfileState {
  const ProfileState({
    required this.profile,
    this.isSaving = false,
    this.error,
  });

  final UserProfile profile;
  final bool isSaving;
  final String? error;

  ProfileState copyWith({
    UserProfile? profile,
    bool? isSaving,
    String? error,
    bool clearError = false,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isSaving: isSaving ?? this.isSaving,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
      : super(
          const ProfileState(
            profile: UserProfile(
              uid: 'mock_uid',
              phoneNumber: '+225 07 18 14 87 79',
              firstName: 'Kouassi',
              lastName: 'Shura',
              email: 'kouassi@luxora.app',
              memberTier: MemberTier.silver,
            ),
          ),
        );

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    state = state.copyWith(isSaving: true, clearError: true);
    await Future<void>.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      isSaving: false,
      profile: state.profile.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
    );
    return true;
  }

  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
