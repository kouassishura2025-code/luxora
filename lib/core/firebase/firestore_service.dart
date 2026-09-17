import 'package:cloud_firestore/cloud_firestore.dart';

import '../error/exceptions.dart';

/// Service Firestore centralisé LUXORA.
class FirestoreService {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  FirebaseFirestore get instance => _firestore;

  Future<Map<String, dynamic>?> getDocument(String path) async {
    try {
      final snapshot = await _firestore.doc(path).get();
      return snapshot.data();
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getCollection(
    String path, {
    Query Function(Query)? queryBuilder,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(path);
      if (queryBuilder != null) query = queryBuilder(query);
      if (limit != null) query = query.limit(limit);
      final snapshot = await query.get();
      return snapshot.docs
          .map((d) => d.data() as Map<String, dynamic>)
          .toList();
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Stream<Map<String, dynamic>?> streamDocument(String path) {
    return _firestore.doc(path).snapshots().map((s) => s.data());
  }

  Stream<List<Map<String, dynamic>>> streamCollection(
    String path, {
    Query Function(Query)? queryBuilder,
    int? limit,
  }) {
    Query query = _firestore.collection(path);
    if (queryBuilder != null) query = queryBuilder(query);
    if (limit != null) query = query.limit(limit);

    return query.snapshots().map(
          (snap) => snap.docs
              .map((d) => d.data() as Map<String, dynamic>)
              .toList(),
        );
  }

  Future<void> setDocument(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  }) async {
    try {
      await _firestore.doc(path).set(data, SetOptions(merge: merge));
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<String> addDocument(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    try {
      final ref = await _firestore.collection(collectionPath).add(data);
      return ref.id;
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> updateDocument(
    String path,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.doc(path).update(data);
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      await _firestore.doc(path).delete();
    } on FirebaseException catch (e) {
      throw _mapError(e);
    }
  }

  AppException _mapError(FirebaseException e) {
    switch (e.code) {
      case 'unavailable':
        return const NetworkException('Service indisponible.');
      case 'permission-denied':
        return const AuthException('Permission refusée.');
      case 'not-found':
        return const ServerException('Ressource introuvable.');
      case 'already-exists':
        return const ValidationException('Existe déjà.');
      default:
        return const ServerException();
    }
  }
}
