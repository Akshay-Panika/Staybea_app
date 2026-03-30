import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class HealthAndWellness extends StatefulWidget {
  const HealthAndWellness({super.key});

  @override
  State<HealthAndWellness> createState() => _HealthAndWellnessState();
}

class _HealthAndWellnessState extends State<HealthAndWellness> {
  String? _selectedExercise;
  String? _selectedHealthCondition;
  String? _selectedConditionType;

  final List<String> _exerciseOptions = [
    'Daily',
    'Several times a week',
    'Once a week',
    'Occasionally',
    'Rarely',
    'Never',
  ];

  final List<String> _healthConditionOptions = [
    'None',
    'Diabetes',
    'Hypertension',
    'Heart Disease',
    'Asthma',
    'Thyroid',
    'Arthritis',
    'Depression / Anxiety',
    'Other',
    'Prefer not to say',
  ];

  final Map<String, List<String>> _conditionTypeMap = {
    'None': ['Not Applicable'],
    'Diabetes': ['Type 1', 'Type 2', 'Gestational', 'Pre-Diabetes'],
    'Hypertension': ['Stage 1', 'Stage 2', 'Isolated Systolic'],
    'Heart Disease': ['Coronary Artery', 'Heart Failure', 'Arrhythmia', 'Other'],
    'Asthma': ['Mild', 'Moderate', 'Severe', 'Exercise-Induced'],
    'Thyroid': ['Hypothyroidism', 'Hyperthyroidism', 'Hashimoto\'s', 'Other'],
    'Arthritis': ['Osteoarthritis', 'Rheumatoid', 'Psoriatic', 'Other'],
    'Depression / Anxiety': ['Depression', 'Anxiety', 'Both', 'Other'],
    'Other': ['Other'],
    'Prefer not to say': ['Prefer not to say'],
  };

  List<String> get _conditionTypes =>
      _selectedHealthCondition != null
          ? (_conditionTypeMap[_selectedHealthCondition] ?? [])
          : [];

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String? selected,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: const Icon(Icons.close,
                          size: 20, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (_, index) {
                    final option = options[index];
                    final isSelected = option == selected;
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        color: isSelected
                            ? Colors.grey.shade100
                            : Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: Colors.black87,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: appSize.height*0.02),

          // Title
           Text(
            "Health & Wellness",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Do you exercise?
          _buildLabel("Do you exercise?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Exercise?",
            selected: _selectedExercise,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Do you exercise?",
              options: _exerciseOptions,
              selected: _selectedExercise,
              onSelected: (val) => setState(() => _selectedExercise = val),
            ),
          ),

          const SizedBox(height: 20),

          // Any health conditions
          _buildLabel("Any health conditions you would like to share?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select  Any health conditiont",
            selected: _selectedHealthCondition,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Health Conditions",
              options: _healthConditionOptions,
              selected: _selectedHealthCondition,
              onSelected: (val) {
                setState(() {
                  _selectedHealthCondition = val;
                  _selectedConditionType = null;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // Type of condition
          _buildLabel("Type of condition"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select  Type of condition",
            selected: _selectedConditionType,
            enabled: _selectedHealthCondition != null,
            onTap: _selectedHealthCondition == null
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Type of condition",
              options: _conditionTypes,
              selected: _selectedConditionType,
              onSelected: (val) =>
                  setState(() => _selectedConditionType = val),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    String? selected,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selected ?? hint,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: selected != null
                      ? Colors.black87
                      : Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: enabled
                    ? Colors.grey.shade500
                    : Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}