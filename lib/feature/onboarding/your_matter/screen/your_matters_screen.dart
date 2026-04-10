import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../bloc/your_matters_bloc.dart';
import '../bloc/your_matters_event.dart';
import '../bloc/your_matters_state.dart';
import '../model/your_matters_model.dart';
import '../repository/your_matters_repository.dart';
import '../widget/you_matters_shimmer.dart';

class YourMattersScreen extends StatelessWidget {
  const YourMattersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YouMattersBloc(YouMattersRepository())
        ..add(FetchYouMattersEvent()),
      child: const _YouMattersView(),
    );
  }
}

class _YouMattersView extends StatelessWidget {
  const _YouMattersView();

  static const Map<String, String> _iconMap = {
    'communication_style': '💬',
    'love_language': '💗',
    'education_level': '🎓',
    'star_sign': '⭐',
  };

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return BlocBuilder<YouMattersBloc, YouMattersState>(
      builder: (context, state) {

        // ── Loading ──────────────────────────────────────────────
        if (state is YouMattersLoading) {
          return const YouMattersShimmer();
        }

        // ── Error ────────────────────────────────────────────────
        if (state is YouMattersError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}',
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context
                      .read<YouMattersBloc>()
                      .add(FetchYouMattersEvent()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ── Loaded ───────────────────────────────────────────────
        if (state is YouMattersLoaded) {
          final questions = state.response.data;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The real you matters.",
                  style: TextStyle(
                    fontSize: appSize.largeText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Don't hold back. The right person will appreciate you",
                  style: TextStyle(
                    fontSize: appSize.mediumText,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: appSize.height * 0.02),

                ...questions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;
                  final icon = _iconMap[question.key] ?? '✨';

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < questions.length - 1 ? 16 : 0,
                    ),
                    child: _mattersCard(
                      context: context,
                      state: state,
                      question: question,
                      icon: icon,
                    ),
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _mattersCard({
    required BuildContext context,
    required YouMattersLoaded state,
    required YouMattersQuestion question,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3EDF7),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Icon + Title ───────────────────────────────────
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Chips — ALL use multiSelections ───────────────
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: question.options.map((option) {
              final isSelected = state.isMultiSelected(question.id, option.value);

              return GestureDetector(
                onTap: () {
                  context.read<YouMattersBloc>().add(
                    ToggleMultiMattersOptionEvent(
                      questionId: question.id,
                      optionValue: option.value,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.pink : Colors.grey.shade400,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (isSelected) ...[
                      //   Icon(
                      //     Icons.check_circle,
                      //     size: 15,
                      //     color: Colors.pink.shade600,
                      //   ),
                      //   const SizedBox(width: 5),
                      // ],
                      Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.pink.shade800
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}