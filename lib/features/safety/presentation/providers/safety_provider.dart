import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/safety_repository.dart';
import '../../domain/entities/emergency_contact.dart';

// ─── Repository ──────────────────────────────────────────
final safetyRepositoryProvider = Provider<SafetyRepository>((ref) {
  return MockSafetyRepository();
});

// ─── Contacts (FutureProvider) ───────────────────────────
final emergencyContactsProvider =
    FutureProvider<List<EmergencyContact>>((ref) {
  return ref.watch(safetyRepositoryProvider).getEmergencyContacts();
});

// ─── État SOS (maintenir 3s) ─────────────────────────────
@immutable
class SosState {
  const SosState({
    this.status = SosStatus.idle,
    this.holdProgress = 0.0,
    this.isTriggering = false,
  });

  final SosStatus status;
  final double holdProgress;
  final bool isTriggering;

  SosState copyWith({
    SosStatus? status,
    double? holdProgress,
    bool? isTriggering,
  }) {
    return SosState(
      status: status ?? this.status,
      holdProgress: holdProgress ?? this.holdProgress,
      isTriggering: isTriggering ?? this.isTriggering,
    );
  }
}

class SosNotifier extends StateNotifier<SosState> {
  SosNotifier(this._repository) : super(const SosState());

  final SafetyRepository _repository;

  Future<void> trigger() async {
    state = state.copyWith(
      status: SosStatus.triggered,
      isTriggering: true,
      holdProgress: 1.0,
    );
    await _repository.triggerSos();
    state = state.copyWith(isTriggering: false);
  }

  void reset() => state = const SosState();
}

final sosProvider = StateNotifierProvider<SosNotifier, SosState>((ref) {
  return SosNotifier(ref.watch(safetyRepositoryProvider));
});

// ─── État de partage de trajet ───────────────────────────
@immutable
class TripSharingState {
  const TripSharingState({
    this.selectedContactIds = const {},
    this.duration = SharingDuration.oneHour,
    this.link,
    this.isGenerating = false,
  });

  final Set<String> selectedContactIds;
  final SharingDuration duration;
  final String? link;
  final bool isGenerating;

  TripSharingState copyWith({
    Set<String>? selectedContactIds,
    SharingDuration? duration,
    String? link,
    bool? isGenerating,
    bool clearLink = false,
  }) {
    return TripSharingState(
      selectedContactIds:
          selectedContactIds ?? this.selectedContactIds,
      duration: duration ?? this.duration,
      link: clearLink ? null : (link ?? this.link),
      isGenerating: isGenerating ?? this.isGenerating,
    );
  }
}

class TripSharingNotifier extends StateNotifier<TripSharingState> {
  TripSharingNotifier(this._repository)
      : super(const TripSharingState());

  final SafetyRepository _repository;

  void toggleContact(String id) {
    final next = Set<String>.from(state.selectedContactIds);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = state.copyWith(
      selectedContactIds: next,
      clearLink: true,
    );
  }

  void setDuration(SharingDuration duration) {
    state = state.copyWith(duration: duration, clearLink: true);
  }

  Future<void> generateLink() async {
    if (state.selectedContactIds.isEmpty) return;
    state = state.copyWith(isGenerating: true);
    final link = await _repository.createTripSharingLink(
      state.selectedContactIds.toList(),
    );
    state = state.copyWith(isGenerating: false, link: link);
  }
}

final tripSharingProvider =
    StateNotifierProvider<TripSharingNotifier, TripSharingState>((ref) {
  return TripSharingNotifier(ref.watch(safetyRepositoryProvider));
});
