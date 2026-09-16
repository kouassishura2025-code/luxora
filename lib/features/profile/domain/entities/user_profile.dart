import 'package:equatable/equatable.dart';

/// Profil utilisateur LUXORA.
class UserProfile extends Equatable {
  const UserProfile({
    required this.uid,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.photoUrl,
    this.memberTier = MemberTier.silver,
    this.createdAt,
  });

  final String uid;
  final String phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? photoUrl;
  final MemberTier memberTier;
  final DateTime? createdAt;

  String get displayName {
    if (firstName == null && lastName == null) return 'Invité';
    if (firstName == null) return lastName!;
    if (lastName == null) return firstName!;
    return '${firstName!} ${lastName!}';
  }

  String get initials {
    final f = firstName?.isNotEmpty == true ? firstName![0] : '';
    final l = lastName?.isNotEmpty == true ? lastName![0] : '';
    final result = '$f$l'.toUpperCase();
    return result.isEmpty ? 'LK' : result;
  }

  UserProfile copyWith({
    String? uid,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? email,
    String? photoUrl,
    MemberTier? memberTier,
    DateTime? createdAt,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      memberTier: memberTier ?? this.memberTier,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        phoneNumber,
        firstName,
        lastName,
        email,
        photoUrl,
        memberTier,
        createdAt,
      ];
}

/// Niveau d'adhésion LUXORA.
enum MemberTier {
  silver('Silver'),
  gold('Gold'),
  black('Black');

  const MemberTier(this.label);
  final String label;
}
