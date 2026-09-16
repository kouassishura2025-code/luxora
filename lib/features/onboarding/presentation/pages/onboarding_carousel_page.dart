import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/buttons/luxora_text_button.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_slide_card.dart';

class OnboardingCarouselPage extends ConsumerStatefulWidget {
  const OnboardingCarouselPage({super.key});

  @override
  ConsumerState<OnboardingCarouselPage> createState() =>
      _OnboardingCarouselPageState();
}

class _OnboardingCarouselPageState
    extends ConsumerState<OnboardingCarouselPage> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next(int total) {
    final current = ref.read(onboardingIndexProvider);
    if (current < total - 1) {
      _controller.nextPage(
        duration: LuxoraDurations.relaxed,
        curve: Curves.easeOutCubic,
      );
    } else {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slides = ref.watch(onboardingSlidesProvider);
    final currentIndex = ref.watch(onboardingIndexProvider);
    final isLast = currentIndex == slides.length - 1;

    return LuxoraScaffold(
      applyPadding: false,
      body: Column(
        children: [
          // ─── Header : Passer ─────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  duration: LuxoraDurations.quick,
                  opacity: isLast ? 0 : 1,
                  child: isLast
                      ? const SizedBox(height: 48)
                      : LuxoraTextButton(
                          label: 'Passer',
                          onPressed: () => context.go(RouteNames.home),
                        ),
                ),
              ],
            ),
          ),

          // ─── Carousel ────────────────────────────────
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: slides.length,
              onPageChanged: (index) {
                ref.read(onboardingIndexProvider.notifier).state = index;
              },
              itemBuilder: (context, index) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OnboardingSlideCard(slide: slides[index]),
                  ),
                );
              },
            ),
          ),

          // ─── Indicateur ──────────────────────────────
          OnboardingIndicator(
            count: slides.length,
            currentIndex: currentIndex,
          ),

          const SizedBox(height: 32),

          // ─── CTA ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedSwitcher(
              duration: LuxoraDurations.quick,
              child: LuxoraPrimaryButton(
                key: ValueKey(isLast),
                label: isLast ? 'Commencer' : 'Continuer',
                onPressed: () => _next(slides.length),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
