import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

class YourSelfScreen extends StatefulWidget {
  const YourSelfScreen({super.key});

  @override
  State<YourSelfScreen> createState() => _YourSelfScreenState();
}

class _YourSelfScreenState extends State<YourSelfScreen> {
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
          AppExpandableField(
            label: "Marital Status",
            hint: 'Select Marital Status',
            value: _selectedMaritalStatus,
            isOpen: _showMaritalStatus,
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

          AppExpandableField(
            label: "Do you have child?",
            hint: "Select have child or not",
            value: _selectedHaveChild,
            isOpen: _showHaveChild,
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
          AppExpandableField(
            label: "Number of child",
            hint: "Select Number of child",
            value: _selectedNumberOfChild,
            isOpen: _showNumberOfChild,
            enabled: _hasChildren,
            onTap: () {
              if (!_hasChildren) return;
              setState(() {
                _showNumberOfChild = !_showNumberOfChild;
                _showMaritalStatus = false;
                _showHaveChild = false;
                _showLiveWithYou = false;
                _showCurrentlyLive = false;
              });
            },
            items: _numberOfChildOptions,
            onSelect: (val) {
              setState(() {
                _selectedNumberOfChild = val;
                _showNumberOfChild = false;
              });
            },
          ),

          AppExpandableField(
            label: "Do they live with you?",
            hint: "live with you",
            value: _selectedLiveWithYou,
            isOpen: _showLiveWithYou,
            enabled: _hasChildren,
            onTap: () {
              if (!_hasChildren) return;
              setState(() {
                _showLiveWithYou = !_showLiveWithYou;
                _showMaritalStatus = false;
                _showHaveChild = false;
                _showNumberOfChild = false;
                _showCurrentlyLive = false;
              });
            },
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
          AppExpandableField(
            label: "Where do you currently live?",
            hint: "Where do you live?",
            value: _selectedCurrentlyLive,
            isOpen: _showCurrentlyLive,
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
}