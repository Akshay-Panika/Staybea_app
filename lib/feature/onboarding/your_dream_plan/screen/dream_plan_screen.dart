import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../your_hobby/widget/interest_hobby_shimmer.dart';
import '../bloc/dream_plan_bloc.dart';
import '../bloc/dream_plan_event.dart';
import '../bloc/dream_plan_state.dart';
import '../repository/dream_plan_repository.dart';

class DreamPlanScreen extends StatefulWidget {
  const DreamPlanScreen({super.key});

  @override
  State<DreamPlanScreen> createState() => _DreamPlanScreenState();
}

class _DreamPlanScreenState extends State<DreamPlanScreen> {
  final Set<String> _selected = {};
  final int _maxSelection = 5;
  final int _minSelection = 3;

  void _toggleSelection(String value) {
    setState(() {
      if (_selected.contains(value)) {
        _selected.remove(value);
      } else {
        if (_selected.length < _maxSelection) {
          _selected.add(value);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      DreamPlanBloc(DreamPlanRepository())
        ..add(FetchDreamPlanEvent()),

      child: BlocBuilder<DreamPlanBloc, DreamPlanState>(
        builder: (context, state) {

          // ✅ LOADING
          if (state is DreamPlanLoading) {
            return const InterestHobbyShimmer();
          }

          // ❌ ERROR
          if (state is DreamPlanError) {
            return Center(child: Text(state.message));
          }

          // ✅ SUCCESS
          if (state is DreamPlanLoaded) {
            final options = state.model.data.first.options;
            final title = state.model.data.first.title;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // TITLE
                  const Text(
                    "Dream Plan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // SUBTITLE
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final isSelected =
                      _selected.contains(option.value);

                      return GestureDetector(
                        onTap: () => _toggleSelection(option.value),

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.pink.shade300
                                  : Colors.grey.shade200,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 32,
                                color: isSelected
                                    ? Colors.pink.shade400
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                option.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? Colors.pink.shade400
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // COUNTER
                  Center(
                    child: Text(
                      "${_selected.length} / $_maxSelection selected",
                      style: TextStyle(
                        fontSize: 13,
                        color: _selected.length >= _minSelection
                            ? Colors.green.shade600
                            : Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}