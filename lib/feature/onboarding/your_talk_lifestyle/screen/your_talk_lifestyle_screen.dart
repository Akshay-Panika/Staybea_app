import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../bloc/your_talk_lifestyle_bloc.dart';
import '../bloc/your_talk_lifestyle_event.dart';
import '../bloc/your_talk_lifestyle_state.dart';
import '../model/your_talk_lifestyle_model.dart';
import '../repository/your_talk_lifestyle_repository.dart';
import '../widget/lifestyle_shimmer.dart';

class YourTalkLifestyleScreen extends StatelessWidget {
  const YourTalkLifestyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LifestyleBloc(LifestyleRepository())
        ..add(FetchLifestyleEvent()),
      child: const _TalkLifestyleView(),
    );
  }
}

class _TalkLifestyleView extends StatelessWidget {
  const _TalkLifestyleView();

  static const Map<String, String> _iconMap = {
    'drinking_habit': '🍾',
    'smoking_habit': '🚬',
    'exercise_habit': '🏋️',
    'pets': '🐾',
  };

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return BlocBuilder<LifestyleBloc, LifestyleState>(
      builder: (context, state) {

        if (state is LifestyleLoading) {
          return LifestyleShimmer();
        }

        if (state is LifestyleError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}',
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context
                      .read<LifestyleBloc>()
                      .add(FetchLifestyleEvent()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is LifestyleLoaded) {
          final questions = state.response.data;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Talk Lifestyle",
                  style: TextStyle(
                    fontSize: appSize.largeText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Habits meet harmony. You go first.",
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
                    child: _lifestyleCard(
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

  Widget _lifestyleCard({
    required BuildContext context,
    required LifestyleLoaded state,
    required LifestyleQuestion question,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
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

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: question.options.map((option) {

              // ✅ always multiSelections
              final isSelected =
              state.isMultiSelected(question.id, option.value);

              return GestureDetector(

                // ✅ always ToggleMultiOptionEvent
                onTap: () {
                  context.read<LifestyleBloc>().add(
                    ToggleMultiOptionEvent(
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
                      color: isSelected
                          ? Colors.pink
                          : Colors.grey.shade300,
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