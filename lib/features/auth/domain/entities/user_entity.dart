import 'package:equatable/equatable.dart';

/// Utilisateur LUXORA.
class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    this.email,
    this.photoUrl,
    this.kycVerified = false,
    this.createdAt,
  });

  final String uid;
  final String phoneNumber;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool kycVerified;
  final DateTime? createdAt;

  UserEntity copyWith({
    String? uid,
    String? phoneNumber,
    String? displayName,
    String? email,
    String? photoUrl,
    bool? kycVerified,
    DateTime? createdAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      kycVerified: kycVerified ?? this.kycVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        phoneNumber,
        displayName,
        email,
        photoUrl,
        kycVerified,
        createdAt,
      ];
}
