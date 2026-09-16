import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/membership_repository.dart';
import '../../domain/entities/membership.dart';

final membershipRepositoryProvider = Provider<MembershipRepository>((ref) {
  return MockMembershipRepository();
});

final membershipProvider = Provider<Membership>((ref) {
  return ref.watch(membershipRepositoryProvider).getMembership('mock_uid');
});

final perksProvider = Provider<List<Perk>>((ref) {
  final membership = ref.watch(membershipProvider);
  return ref
      .watch(membershipRepositoryProvider)
      .getPerksForTier(membership.tier);
});

final pointsHistoryProvider = Provider<List<PointsEvent>>((ref) {
  return ref
      .watch(membershipRepositoryProvider)
      .getPointsHistory('mock_uid');
});
