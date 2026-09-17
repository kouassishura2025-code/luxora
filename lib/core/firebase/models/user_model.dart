import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/auth/domain/entities/user_entity.dart';

/// Modèle Firestore pour un utilisateur.
///
/// - `fromFirestore` : convertit un document Firestore en `UserEntity`
/// - `toFirestore`   : convertit un `UserEntity` en Map Firestore
abstract final class UserModel {
  static UserEntity fromFirestore(
    String uid,
    Map<String, dynamic> data,
  ) {
    return UserEntity(
      uid: uid,
      phoneNumber: data['phoneNumber'] as String? ?? '',
      displayName: data['displayName'] as String?,
      email: data['email'] as String?,
      photoUrl: data['photoUrl'] as String?,
      kycVerified: data['kycVerified'] as bool? ?? false,
      createdAt: _parseDate(data['createdAt']),
    );
  }

  static Map<String, dynamic> toFirestore(UserEntity user) {
    return {
      'uid': user.uid,
      'phoneNumber': user.phoneNumber,
      'displayName': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'kycVerified': user.kycVerified,
      'createdAt': user.createdAt != null
          ? Timestamp.fromDate(user.createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
