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

  bool _showMaritalStatus = false;
  bool _showHaveChild = false;
  bool _showNumberOfChild = false;
  bool _showLiveWithYou = false;
  bool _showCurrentlyLive = false;

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

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSize.height * 0.02),

          Text(
            "More about yourself",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          // Marital Status
          _buildExpandableField(
            label: "Marital Status",
            value: _selectedMaritalStatus,
            isOpen: _showMaritalStatus,
            appSize: appSize,
            onTap: () {
              setState(() {
                _showMaritalStatus = !_showMaritalStatus;
                _showHaveChild = false;
                _showNumberOfChild = false;
                _showLiveWithYou = false;
                _showCurrentlyLive = false;
              });
            },
            items: _maritalStatuses,
            onSelect: (val) {
              setState(() {
                _selectedMaritalStatus = val;
                _showMaritalStatus = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Do you have child
          _buildExpandableField(
            label: "Do you have child?",
            value: _selectedHaveChild,
            isOpen: _showHaveChild,
            appSize: appSize,
            onTap: () {
              setState(() {
                _showHaveChild = !_showHaveChild;
                _showMaritalStatus = false;
                _showNumberOfChild = false;
                _showLiveWithYou = false;
                _showCurrentlyLive = false;
              });
            },
            items: _haveChildOptions,
            onSelect: (val) {
              setState(() {
                _selectedHaveChild = val;
                if (val == 'No') {
                  _selectedNumberOfChild = null;
                  _selectedLiveWithYou = null;
                }
                _showHaveChild = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Number of child
          _buildExpandableField(
            label: "Number of child",
            value: _selectedNumberOfChild,
            isOpen: _showNumberOfChild,
            enabled: _hasChildren,
            appSize: appSize,
            onTap: _hasChildren
                ? () {
              setState(() {
                _showNumberOfChild = !_showNumberOfChild;
                _showMaritalStatus = false;
                _showHaveChild = false;
                _showLiveWithYou = false;
                _showCurrentlyLive = false;
              });
            }
                : null,
            items: _numberOfChildOptions,
            onSelect: (val) {
              setState(() {
                _selectedNumberOfChild = val;
                _showNumberOfChild = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Do they live with you?
          _buildExpandableField(
            label: "Do they live with you?",
            value: _selectedLiveWithYou,
            isOpen: _showLiveWithYou,
            enabled: _hasChildren,
            appSize: appSize,
            onTap: _hasChildren
                ? () {
              setState(() {
                _showLiveWithYou = !_showLiveWithYou;
                _showMaritalStatus = false;
                _showHaveChild = false;
                _showNumberOfChild = false;
                _showCurrentlyLive = false;
              });
            }
                : null,
            items: _liveWithYouOptions,
            onSelect: (val) {
              setState(() {
                _selectedLiveWithYou = val;
                _showLiveWithYou = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Currently live
          _buildExpandableField(
            label: "Where do you currently live?",
            value: _selectedCurrentlyLive,
            isOpen: _showCurrentlyLive,
            appSize: appSize,
            onTap: () {
              setState(() {
                _showCurrentlyLive = !_showCurrentlyLive;
                _showMaritalStatus = false;
                _showHaveChild = false;
                _showNumberOfChild = false;
                _showLiveWithYou = false;
              });
            },
            items: _currentlyLiveOptions,
            onSelect: (val) {
              setState(() {
                _selectedCurrentlyLive = val;
                _showCurrentlyLive = false;
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
                      color: value != null
                          ? Colors.black87
                          : Colors.grey.shade400,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: appSize.mediumText,
                                color: isSelected ? Colors.black : Colors.black54),
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