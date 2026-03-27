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

  final List<String> _countries = [
    'India', 'United States', 'United Kingdom', 'Canada',
    'Australia', 'Germany', 'France', 'UAE', 'Singapore', 'Other',
  ];

  final Map<String, List<String>> _stateMap = {
    'India': ['Maharashtra', 'Delhi', 'Karnataka', 'Tamil Nadu', 'Gujarat', 'Rajasthan', 'Punjab', 'Kerala'],
    'United States': ['California', 'New York', 'Texas', 'Florida', 'Illinois', 'Washington'],
    'United Kingdom': ['England', 'Scotland', 'Wales', 'Northern Ireland'],
    'Canada': ['Ontario', 'Quebec', 'British Columbia', 'Alberta'],
    'Australia': ['New South Wales', 'Victoria', 'Queensland', 'Western Australia'],
    'Germany': ['Bavaria', 'Berlin', 'Hamburg', 'Hesse'],
    'France': ['Île-de-France', 'Provence', 'Normandy', 'Brittany'],
    'UAE': ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman'],
    'Singapore': ['Central', 'East', 'North', 'West'],
    'Other': ['Other'],
  };

  final Map<String, List<String>> _cityMap = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad'],
    'Delhi': ['New Delhi', 'Dwarka', 'Rohini', 'Saket'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Salem'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota'],
    'Punjab': ['Chandigarh', 'Ludhiana', 'Amritsar', 'Jalandhar'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Thrissur'],
    'California': ['Los Angeles', 'San Francisco', 'San Diego', 'Sacramento'],
    'New York': ['New York City', 'Buffalo', 'Rochester', 'Albany'],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville'],
    'Illinois': ['Chicago', 'Springfield', 'Naperville'],
    'Washington': ['Seattle', 'Spokane', 'Tacoma'],
    'England': ['London', 'Manchester', 'Birmingham', 'Leeds'],
    'Scotland': ['Edinburgh', 'Glasgow', 'Aberdeen'],
    'Wales': ['Cardiff', 'Swansea', 'Newport'],
    'Northern Ireland': ['Belfast', 'Derry'],
    'Ontario': ['Toronto', 'Ottawa', 'Mississauga'],
    'Quebec': ['Montreal', 'Quebec City', 'Laval'],
    'British Columbia': ['Vancouver', 'Victoria', 'Kelowna'],
    'Alberta': ['Calgary', 'Edmonton', 'Red Deer'],
    'New South Wales': ['Sydney', 'Newcastle', 'Wollongong'],
    'Victoria': ['Melbourne', 'Geelong', 'Ballarat'],
    'Queensland': ['Brisbane', 'Gold Coast', 'Cairns'],
    'Western Australia': ['Perth', 'Fremantle', 'Bunbury'],
    'Bavaria': ['Munich', 'Nuremberg', 'Augsburg'],
    'Berlin': ['Berlin'],
    'Hamburg': ['Hamburg'],
    'Hesse': ['Frankfurt', 'Wiesbaden', 'Darmstadt'],
    'Île-de-France': ['Paris', 'Versailles', 'Boulogne-Billancourt'],
    'Provence': ['Marseille', 'Nice', 'Toulon'],
    'Normandy': ['Rouen', 'Caen', 'Le Havre'],
    'Brittany': ['Rennes', 'Brest', 'Quimper'],
    'Dubai': ['Dubai Marina', 'Downtown Dubai', 'Deira', 'Jumeirah'],
    'Abu Dhabi': ['Abu Dhabi City', 'Al Ain', 'Khalifa City'],
    'Sharjah': ['Sharjah City', 'Khor Fakkan'],
    'Ajman': ['Ajman City'],
    'Central': ['Orchard', 'Marina Bay', 'Raffles Place'],
    'East': ['Tampines', 'Bedok', 'Pasir Ris'],
    'North': ['Woodlands', 'Yishun', 'Sembawang'],
    'West': ['Jurong', 'Clementi', 'Buona Vista'],
    'Other': ['Other'],
  };

  List<String> get _states =>
      _selectedCountry != null ? (_stateMap[_selectedCountry] ?? []) : [];

  List<String> get _cities =>
      _selectedState != null ? (_cityMap[_selectedState] ?? []) : [];

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                      child: const Icon(Icons.close, size: 20, color: Colors.black54),
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
                          horizontal: 20,
                          vertical: 14,
                        ),
                        color: isSelected ? Colors.grey.shade100 : Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
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
            "Location",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Country
           Text(
            "Country",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select Country",
            selected: _selectedCountry,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Select Country",
              options: _countries,
              selected: _selectedCountry,
              onSelected: (val) {
                setState(() {
                  _selectedCountry = val;
                  _selectedState = null;
                  _selectedCity = null;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // State
          const Text(
            "State",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select State",
            selected: _selectedState,
            enabled: _selectedCountry != null,
            onTap: _selectedCountry == null
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Select State",
              options: _states,
              selected: _selectedState,
              onSelected: (val) {
                setState(() {
                  _selectedState = val;
                  _selectedCity = null;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // City
          const Text(
            "City",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select City",
            selected: _selectedCity,
            enabled: _selectedState != null,
            onTap: _selectedState == null
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Select City",
              options: _cities,
              selected: _selectedCity,
              onSelected: (val) {
                setState(() => _selectedCity = val);
              },
            ),
          ),
        ],
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
                color: selected != null ? Colors.black87 : Colors.grey.shade400,
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
                color: enabled ? Colors.grey.shade500 : Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}