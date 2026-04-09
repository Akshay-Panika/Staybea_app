import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

import '../../../../core/widget/app_expandable_field.dart';

class YourLocationScreen extends StatefulWidget {
  const YourLocationScreen({super.key});

  @override
  State<YourLocationScreen> createState() => _YourLocationScreenState();
}

class _YourLocationScreenState extends State<YourLocationScreen> {
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
            "Your Location",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          /// 🌍 Country
          AppExpandableField(
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
          AppExpandableField(
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
          AppExpandableField(
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
}