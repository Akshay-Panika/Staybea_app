import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

import '../bloc/health_wellness_bloc.dart';
import '../bloc/health_wellness_event.dart';
import '../bloc/health_wellness_state.dart';
import '../repository/health_wellness_repository.dart';
import '../model/health_wellness_model.dart';
import '../widget/health_shimmer.dart';

class YourHealthScreen extends StatefulWidget {
  const YourHealthScreen({super.key});

  @override
  State<YourHealthScreen> createState() => _YourHealthScreenState();
}

class _YourHealthScreenState extends State<YourHealthScreen> {
  String? _selectedExercise;
  String? _selectedHealthCondition;
  String? _selectedConditionType;

  bool _showExercise = false;
  bool _showHealthCondition = false;
  bool _showConditionType = false;

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return BlocProvider(
      create: (context) =>
      HealthWellnessBloc(HealthWellnessRepository())
        ..add(FetchHealthWellnessEvent()),
      child: BlocBuilder<HealthWellnessBloc, HealthWellnessState>(
        builder: (context, state) {

          // 🔹 Loading
          if (state is HealthWellnessLoading) {
            return HealthShimmer();
          }

          // 🔹 Error
          if (state is HealthWellnessError) {
            return Center(child: Text(state.message));
          }

          // 🔹 Success
          if (state is HealthWellnessLoaded) {
            final questions = state.questions;

            HealthWellnessModel? exerciseQ;
            HealthWellnessModel? healthQ;
            HealthWellnessModel? conditionQ;

            for (var q in questions) {
              if (q.key == "exercise") exerciseQ = q;
              if (q.key == "health_conditions") healthQ = q;
              if (q.key == "condition_type") conditionQ = q;
            }

            final exerciseOptions =
                exerciseQ?.options.map((e) => e.label).toList() ?? [];

            final healthOptions =
                healthQ?.options.map((e) => e.label).toList() ?? [];

            final conditionOptions =
                conditionQ?.options.map((e) => e.label).toList() ?? [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: appSize.height * 0.02),

                  // 🔹 Title
                  Text(
                    "Health & Wellness",
                    style: TextStyle(
                      fontSize: appSize.largeText,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: appSize.height * 0.02),

                  // ================= EXERCISE =================
                  AppExpandableField(
                    label: exerciseQ?.title ?? "Do you exercise?",
                    hint: "Exercise?",
                    value: _selectedExercise,
                    isOpen: _showExercise,
                    onTap: () {
                      setState(() {
                        _showExercise = !_showExercise;
                        _showHealthCondition = false;
                        _showConditionType = false;
                      });
                    },
                    items: exerciseOptions,
                    onSelect: (val) {
                      setState(() {
                        _selectedExercise = val;
                        _showExercise = false;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // ================= HEALTH CONDITION =================
                  AppExpandableField(
                    label: healthQ?.title ??
                        "Any health conditions you would like to share?",
                    hint: "Select  Any health conditions",
                    value: _selectedHealthCondition,
                    isOpen: _showHealthCondition,
                    onTap: () {
                      setState(() {
                        _showHealthCondition = !_showHealthCondition;
                        _showExercise = false;
                        _showConditionType = false;
                      });
                    },
                    items: healthOptions,
                    onSelect: (val) {
                      setState(() {
                        _selectedHealthCondition = val;
                        _selectedConditionType = null;
                        _showHealthCondition = false;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // ================= CONDITION TYPE =================
                  AppExpandableField(
                    label: conditionQ?.title ?? "Type of condition",
                    hint: "Select Type of condition",
                    value: _selectedConditionType,
                    isOpen: _showConditionType,
                    enabled: _selectedHealthCondition != null,
                    onTap: () {
                      if (_selectedHealthCondition == null) return;

                      setState(() {
                        _showConditionType = !_showConditionType;
                        _showExercise = false;
                        _showHealthCondition = false;
                      });
                    },
                    items: conditionOptions,
                    onSelect: (val) {
                      setState(() {
                        _selectedConditionType = val;
                        _showConditionType = false;
                      });
                    },
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