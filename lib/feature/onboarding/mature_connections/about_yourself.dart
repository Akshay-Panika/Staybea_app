import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class MoreAboutYourself extends StatefulWidget {
  const MoreAboutYourself({super.key});

  @override
  State<MoreAboutYourself> createState() => _MoreAboutYourselfState();
}

class _MoreAboutYourselfState extends State<MoreAboutYourself> {
  String? _selectedMaritalStatus;
  String? _selectedHaveChild;
  String? _selectedNumberOfChild;
  String? _selectedLiveWithYou;
  String? _selectedCurrentlyLive;

  final List<String> _maritalStatuses = [
    'Never Married',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
    'Annulled',
  ];

  final List<String> _haveChildOptions = [
    'No',
    'Yes',
  ];

  final List<String> _numberOfChildOptions = [
    '1', '2', '3', '4', '5+',
  ];

  final List<String> _liveWithYouOptions = [
    'Yes, they live with me',
    'No, they do not live with me',
    'Occasionally',
  ];

  final List<String> _currentlyLiveOptions = [
    'Alone',
    'With Parents',
    'With Roommates',
    'With Family',
    'With Children',
    'Other',
  ];

  bool get _hasChildren =>
      _selectedHaveChild != null && _selectedHaveChild != 'No';

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
            "More about yourself",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Marital Status
          _buildLabel("Marital Status"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select Marital Status",
            selected: _selectedMaritalStatus,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Marital Status",
              options: _maritalStatuses,
              selected: _selectedMaritalStatus,
              onSelected: (val) =>
                  setState(() => _selectedMaritalStatus = val),
            ),
          ),

          const SizedBox(height: 20),

          // Do you have child
          _buildLabel("Do you have child"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "select have child or not",
            selected: _selectedHaveChild,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Do you have child?",
              options: _haveChildOptions,
              selected: _selectedHaveChild,
              onSelected: (val) {
                setState(() {
                  _selectedHaveChild = val;
                  if (val == 'No') {
                    _selectedNumberOfChild = null;
                    _selectedLiveWithYou = null;
                  }
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // Number of child
          _buildLabel("Number of child"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "select Number of child",
            selected: _selectedNumberOfChild,
            enabled: _hasChildren,
            onTap: !_hasChildren
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Number of child",
              options: _numberOfChildOptions,
              selected: _selectedNumberOfChild,
              onSelected: (val) =>
                  setState(() => _selectedNumberOfChild = val),
            ),
          ),

          const SizedBox(height: 20),

          // Do they live with you?
          _buildLabel("Do they live with you?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "live with you",
            selected: _selectedLiveWithYou,
            enabled: _hasChildren,
            onTap: !_hasChildren
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Do they live with you?",
              options: _liveWithYouOptions,
              selected: _selectedLiveWithYou,
              onSelected: (val) =>
                  setState(() => _selectedLiveWithYou = val),
            ),
          ),

          const SizedBox(height: 20),

          // Where do you currently live?
          _buildLabel("Where do you currently live?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Where do you live?",
            selected: _selectedCurrentlyLive,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Where do you currently live?",
              options: _currentlyLiveOptions,
              selected: _selectedCurrentlyLive,
              onSelected: (val) =>
                  setState(() => _selectedCurrentlyLive = val),
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
            Text(
              selected ?? hint,
              style: TextStyle(
                fontSize: 14,
                color:
                selected != null ? Colors.black87 : Colors.grey.shade400,
              ),
            ),
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
                color:
                enabled ? Colors.grey.shade500 : Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}