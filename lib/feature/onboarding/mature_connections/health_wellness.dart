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

  bool _showExercise = false;
  bool _showHealthCondition = false;
  bool _showConditionType = false;

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

  bool get _hasCondition => _selectedHealthCondition != null;

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSize.height * 0.02),

          // Title
          Text(
            "Health & Wellness",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          // Exercise
          _buildExpandableField(
            label: "Do you exercise?",
            value: _selectedExercise,
            isOpen: _showExercise,
            appSize: appSize,
            onTap: () {
              setState(() {
                _showExercise = !_showExercise;
                _showHealthCondition = false;
                _showConditionType = false;
              });
            },
            items: _exerciseOptions,
            onSelect: (val) {
              setState(() {
                _selectedExercise = val;
                _showExercise = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Health Condition
          _buildExpandableField(
            label: "Any health conditions?",
            value: _selectedHealthCondition,
            isOpen: _showHealthCondition,
            appSize: appSize,
            onTap: () {
              setState(() {
                _showHealthCondition = !_showHealthCondition;
                _showExercise = false;
                _showConditionType = false;
              });
            },
            items: _healthConditionOptions,
            onSelect: (val) {
              setState(() {
                _selectedHealthCondition = val;
                _selectedConditionType = null; // reset
                _showHealthCondition = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Condition Type
          _buildExpandableField(
            label: "Type of condition",
            value: _selectedConditionType,
            isOpen: _showConditionType,
            enabled: _hasCondition,
            appSize: appSize,
            onTap: _hasCondition
                ? () {
              setState(() {
                _showConditionType = !_showConditionType;
                _showExercise = false;
                _showHealthCondition = false;
              });
            }
                : null,
            items: _conditionTypes,
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

  Widget _buildExpandableField({
    required String label,
    required String? value,
    required bool isOpen,
    required VoidCallback? onTap,
    required List<String> items,
    required AppSize appSize,
    required Function(String) onSelect,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? "Select $label",
                    style: TextStyle(
                      fontSize: appSize.mediumText,
                      color:
                      value != null ? Colors.black87 : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: enabled ? Colors.grey.shade600 : Colors.grey.shade300,
                )
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: items.map((item) {
                final isSelected = value == item;
                return InkWell(
                  onTap: () => onSelect(item),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: appSize.mediumText,
                              color: isSelected ? Colors.black : Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isSelected ? Colors.pink : Colors.grey),
                          ),
                          child: isSelected
                              ? const Center(
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.pink,
                            ),
                          )
                              : null,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}