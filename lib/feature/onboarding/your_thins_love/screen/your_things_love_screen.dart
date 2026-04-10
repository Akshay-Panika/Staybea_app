import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/core/utils/app_size.dart';

import '../bloc/your_things_love_bloc.dart';
import '../bloc/your_things_love_event.dart';
import '../bloc/your_things_love_state.dart';
import '../model/your_things_love_model.dart';
import '../repository/your_things_love_repository.dart';
import '../widget/you_things_love_shimmer.dart';

class YourThingsLoveScreen extends StatelessWidget {
  const YourThingsLoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YourThingsLoveBloc(YourThingsLoveRepository())
        ..add(FetchYourThingsLoveEvent()),
      child: const _YourThingsLoveView(),
    );
  }
}

class _YourThingsLoveView extends StatelessWidget {
  const _YourThingsLoveView();

  static const Map<String, String> _iconMap = {
    'fan_favourites': '🔥',
    'creativity_interests': '🎨',
    'food_and_drinks': '🍔',
    'gaming': '🎮',
  };

  @override
  Widget build(BuildContext context) {
    final appSize = AppSize(context);

    return BlocBuilder<YourThingsLoveBloc, YourThingsLoveState>(
      builder: (context, state) {

        if (state is YourThingsLoveLoading) {
          return const YouThingsLoveShimmer();
        }

        if (state is YourThingsLoveError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context
                      .read<YourThingsLoveBloc>()
                      .add(FetchYourThingsLoveEvent()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ── Loaded ──────────────────────────────
        if (state is YourThingsLoveLoaded) {
          final questions = state.response.data;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Things you love ❤️",
                  style: TextStyle(
                    fontSize: appSize.largeText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Pick what defines your personality best",
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
                    child: _thingsLoveCard(
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

  Widget _thingsLoveCard({
    required BuildContext context,
    required YourThingsLoveLoaded state,
    required YourThingsLoveQuestion question,
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
          // ── Title ─────────────────────────────
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

          // ── Chips ─────────────────────────────
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: question.options.map((option) {
              final isSelected =
              state.isSelected(question.id, option.value);

              return GestureDetector(
                onTap: () {
                  context.read<YourThingsLoveBloc>().add(
                    ToggleThingsLoveOptionEvent(
                      questionId: question.id,
                      optionValue: option.value,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                      isSelected ? Colors.pink : Colors.grey.shade400,
                    ),
                  ),
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.pink.shade800
                          : Colors.black87,
                    ),
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