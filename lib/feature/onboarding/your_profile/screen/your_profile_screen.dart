import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staybea_app/core/utils/app_size.dart';

import '../../../../core/constant/App_color.dart';
import '../../../../core/widget/app_expandable_field.dart';
import '../../../../core/widget/app_input_field.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileStepState();
}

class _YourProfileStepState extends State<YourProfileScreen> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedHeight;
  String? _selectedGender;
  bool _showHeightOptions = false;

  final List<String> _heights = [
    'Below 5ft',
    '5ft',
    '5ft 1in',
    '5ft 2in',
    '5ft 3in',
    '5ft 4in',
    '5ft 5in',
    '5ft 6in',
    '5ft 7in',
    '5ft 8in',
    '5ft 9in',
    '5ft 10in',
    '5ft 11in',
    '6ft',
    '6ft 1in',
    '6ft 2in',
    '6ft 3in',
    'Above 6ft 3in',
  ];
  final List<String> _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AppSize appSize = AppSize(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(appSize: appSize),
          const SizedBox(height: 36),
          AppInputField(
            label: 'Full Name',
            controller: _nameController,
            hint: 'Enter your full name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          AppInputField(
            label: 'Email Id',
            controller: _emailController,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildDOBField(appSize: appSize),
          const SizedBox(height: 20),
          AppExpandableField(
            label: 'Height',
            hint: 'Select Height',
            value: _selectedHeight,
            isOpen: _showHeightOptions,
            isDOB: false,
            onTap: () {
              setState(() => _showHeightOptions = !_showHeightOptions);
            },
            items: _heights,
            onSelect: (val) {
              setState(() {
                _selectedHeight = val;
                _showHeightOptions = false;
              });
            },
          ),

          const SizedBox(height: 20),
          _buildExpandableDOBField(
            label: 'Select Gender',
            hint: 'Your Gender',
            // value: _selectedGender,
            appSize: appSize,
            items: _genders,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required AppSize appSize,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's set up your profile.",
          style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black87
          ),
        ),

      ],
    );
  }


  Widget _buildExpandableDOBField({
    required String label,
    required String hint,
    required AppSize appSize,
    required List<String> items,
  }) {
    bool isOpen = false; // local open/close state

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: appSize.mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            Stack(
              children: [
                // Main Box
                GestureDetector(
                  onTap: () => setState(() => isOpen = !isOpen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedGender ?? hint, // <-- directly use parent variable
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedGender == null
                                  ? Colors.grey.shade400
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),

                // Dropdown List
                if (isOpen)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
                    ),
                    child: Column(
                      children: items.map((item) {
                        final isSelected = _selectedGender == item; // use parent variable

                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedGender = item;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: appSize.mediumText,
                                          color: isSelected ? Colors.black : Colors.black54,
                                        ),
                                      ),
                                      if (isSelected)
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedGender = item;
                                              // isOpen = false;
                                              // open diloag here
                                              _showGenderIdentityDialog(context, appSize);
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(0, 0),
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Identify your gender',
                                                style: TextStyle(
                                                  fontSize: appSize.smallText,
                                                  color: AppColors.secondary,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_outlined,
                                                color: AppColors.secondary,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // Radio Circle
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? Colors.pink : Colors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDOBField({required AppSize appSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            /// Day
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
                ),
                child: TextField(
                  controller: _dayController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style:  TextStyle(
                    fontSize: appSize.mediumText,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: 'DD',
                    hintStyle: TextStyle(
                      fontSize: appSize.mediumText,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (val) {
                    if (val.length == 2) {
                      FocusScope.of(context).nextFocus(); // auto jump to MM
                    }
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Month
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
                ),
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: appSize.mediumText,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: 'MM',
                    hintStyle: TextStyle(
                      fontSize: appSize.mediumText,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (val) {
                    if (val.length == 2) {
                      FocusScope.of(context).nextFocus(); // auto jump to YYYY
                    }
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Year
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
                ),
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style:  TextStyle(
                    fontSize: appSize.mediumText,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: 'YYYY',
                    hintStyle: TextStyle(
                      fontSize: appSize.mediumText,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  void _showGenderIdentityDialog(BuildContext context, AppSize appSize) {
    final options = [
      {
        'title': 'Straight',
        'desc': 'A person who is exclusive attracted to members of the opposite gender',
      },
      {
        'title': 'Gay',
        'desc': 'An umbrella term used to describe someone who is attracted to members of their gender',
      },
      {
        'title': 'Lesbian',
        'desc': 'A person who is exclusive attracted to members of the opposite gender',
      },
      {
        'title': 'Aromantic',
        'desc': 'A person who does not experience romantic attraction, although they may still experience sexual',
      },
      {
        'title': 'Asexual',
        'desc': 'A person who may not experience sexual attraction or may experience a limited amount of sexual desire. May still experience romantic or desire.',
      },
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(16),
              color: Colors.white,
            ),
            // constraints: const BoxConstraints(maxHeight: 500),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with back button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Select Gender Identity',
                      style: TextStyle(
                        fontSize: appSize.mediumText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // List of options
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final isSelected = _selectedGender == option['title'];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.pink : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            option['title']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(option['desc']!),
                          onTap: () {
                            setState(() {
                              _selectedGender = option['title'];
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
