import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/services/geocoding_service.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/inputs/luxora_text_field.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_progress.dart';

final _geocodingServiceProvider = Provider<GeocodingService>((ref) {
  return GeocodingService();
});

class DestinationEntryPage extends ConsumerStatefulWidget {
  const DestinationEntryPage({super.key});

  @override
  ConsumerState<DestinationEntryPage> createState() =>
      _DestinationEntryPageState();
}

class _DestinationEntryPageState extends ConsumerState<DestinationEntryPage> {
  late final TextEditingController _pickupCtrl;
  late final TextEditingController _destinationCtrl;

  List<GeocodingResult> _suggestions = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    final state = ref.read(bookingProvider);
    _pickupCtrl = TextEditingController(text: state.pickup);
    _destinationCtrl = TextEditingController(text: state.destination ?? '');
  }

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _destinationCtrl.dispose();
    super.dispose();
  }

  Future<void> _searchDestination(String query) async {
    if (query.length < 3) {
      setState(() => _suggestions = []);
      return;
    }
    setState(() => _isSearching = true);
    final results =
        await ref.read(_geocodingServiceProvider).search(query);
    if (!mounted) return;
    setState(() {
      _suggestions = results;
      _isSearching = false;
    });
  }

  void _selectDestination(GeocodingResult result) {
    _destinationCtrl.text = result.label;
    setState(() => _suggestions = []);
    FocusScope.of(context).unfocus();
  }

  void _continue() {
    final notifier = ref.read(bookingProvider.notifier);
    notifier.setPickup(_pickupCtrl.text.trim());
    notifier.setDestination(_destinationCtrl.text.trim());
    context.go(RouteNames.vehicleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Réservation',
        title: 'Destination',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const BookingProgress(currentStep: 1),
          const SizedBox(height: 40),

          Text('Où allons-nous ?',
              style: LuxoraTextStyles.displayMedium,),
          const SizedBox(height: 8),
          Text(
            'Indiquez votre point de départ et votre destination.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: 40),

          LuxoraTextField(
            controller: _pickupCtrl,
            label: 'Départ',
            hint: 'Position actuelle',
            prefixIcon: Icons.my_location_outlined,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          LuxoraTextField(
            controller: _destinationCtrl,
            label: 'Destination',
            hint: 'Adresse, lieu, monument…',
            prefixIcon: Icons.location_on_outlined,
            textInputAction: TextInputAction.done,
            onChanged: _searchDestination,
            onSubmitted: (_) => _continue(),
          ),

          const SizedBox(height: 16),

          // ─── Suggestions ──────────────────────────────
          Expanded(
            child: _isSearching
                ? const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: LuxoraColors.champagne,
                      ),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _suggestions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final s = _suggestions[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _selectDestination(s),
                          borderRadius: LuxoraRadii.brMd,
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: LuxoraColors.charcoal,
                              borderRadius: LuxoraRadii.brMd,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  size: 18,
                                  color: LuxoraColors.champagne,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    s.label,
                                    style: LuxoraTextStyles.bodyMedium
                                        .copyWith(
                                      color: LuxoraColors.textPrimary,
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: LuxoraSpacing.md),

          LuxoraPrimaryButton(
            label: 'Continuer',
            icon: Icons.arrow_forward_rounded,
            onPressed:
                _destinationCtrl.text.trim().isEmpty ? null : _continue,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
