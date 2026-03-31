import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  bool _showCountry = false;
  bool _showState = false;
  bool _showCity = false;

  final List<String> _countries = [
    'India','United States','United Kingdom','Canada',
    'Australia','Germany','France','UAE','Singapore','Other',
  ];

  final Map<String, List<String>> _stateMap = {
    'India': ['Maharashtra','Delhi','Karnataka','Tamil Nadu'],
    'United States': ['California','New York','Texas'],
    'United Kingdom': ['England','Scotland'],
    'Other': ['Other'],
  };

  final Map<String, List<String>> _cityMap = {
    'Maharashtra': ['Mumbai','Pune'],
    'California': ['Los Angeles','San Francisco'],
    'England': ['London','Manchester'],
    'Other': ['Other'],
  };

  List<String> get _states =>
      _selectedCountry != null ? (_stateMap[_selectedCountry] ?? []) : [];

  List<String> get _cities =>
      _selectedState != null ? (_cityMap[_selectedState] ?? []) : [];

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
            "Location",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          /// 🌍 Country
          _buildExpandableField(
            label: "Country",
            hint: "Select Country",
            value: _selectedCountry,
            isOpen: _showCountry,
            onTap: () {
              setState(() {
                if (_showCountry) {
                  _showCountry = false;
                } else {
                  _showCountry = true;
                  _showState = false;
                  _showCity = false;
                }
              });
            },
            items: _countries,
            onSelect: (val) {
              setState(() {
                _selectedCountry = val;
                _selectedState = null;
                _selectedCity = null;
                _showCountry = false;
              });
            },
          ),

          const SizedBox(height: 20),

          /// 🏙 State
          _buildExpandableField(
            label: "State",
            hint: "Select State",
            value: _selectedState,
            isOpen: _showState,
            enabled: _selectedCountry != null,
            onTap: () {
              if (_selectedCountry == null) return;

              setState(() {
                if (_showState) {
                  _showState = false;
                } else {
                  _showState = true;
                  _showCountry = false;
                  _showCity = false;
                }
              });
            },
            items: _states,
            onSelect: (val) {
              setState(() {
                _selectedState = val;
                _selectedCity = null;
                _showState = false;
              });
            },
          ),

          const SizedBox(height: 20),

          /// 🏢 City
          _buildExpandableField(
            label: "City",
            hint: "Select City",
            value: _selectedCity,
            isOpen: _showCity,
            enabled: _selectedState != null,
            onTap: () {
              if (_selectedState == null) return;

              setState(() {
                if (_showCity) {
                  _showCity = false;
                } else {
                  _showCity = true;
                  _showCountry = false;
                  _showState = false;
                }
              });
            },
            items: _cities,
            onSelect: (val) {
              setState(() {
                _selectedCity = val;
                _showCity = false;
              });
            },
          ),
        ],
      ),
    );
  }

  /// 🔥 COMMON UI
  Widget _buildExpandableField({
    required String label,
    required String hint,
    required String? value,
    required bool isOpen,
    required VoidCallback onTap,
    required List<String> items,
    required Function(String) onSelect,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        /// Main Box
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
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: value != null
                          ? Colors.black87
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: enabled
                      ? Colors.grey.shade600
                      : Colors.grey.shade300,
                )
              ],
            ),
          ),
        ),

        /// Expand List
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
                        Expanded(child: Text(item, style: TextStyle(color: isSelected ? Colors.black : Colors.black54),)),

                        /// Radio UI
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.pink
                                  : Colors.grey,
                            ),
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