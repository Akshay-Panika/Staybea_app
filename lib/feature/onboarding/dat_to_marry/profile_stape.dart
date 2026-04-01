import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class ProfileStep extends StatefulWidget {
  const ProfileStep({super.key});

  @override
  State<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends State<ProfileStep> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedHeight;
  String? _selectedGender;
  bool _showHeightOptions = false;
  bool _showGenderOptions = false;

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
          _buildInputField(
            label: 'Full Name',
            controller: _nameController,
            hint: 'Enter your full name',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            appSize: appSize,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            label: 'Email Id',
            controller: _emailController,
            hint: 'Enter your email',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            appSize: appSize,
          ),
          const SizedBox(height: 20),
          _buildDOBField(appSize: appSize),
          const SizedBox(height: 20),
          _buildExpandableField(
            label: 'Height',
            hint: 'Select Height',
            value: _selectedHeight,
            isOpen: _showHeightOptions,
            appSize: appSize,
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
          _buildExpandableField(
            label: 'Select Gender',
            hint: 'Your Gender',
            value: _selectedGender,
            isOpen: _showGenderOptions,
            appSize: appSize,
            onTap: () {
              setState(() => _showGenderOptions = !_showGenderOptions);
            },
            items: _genders,
            onSelect: (val) {
              setState(() {
                _selectedGender = val;
                _showGenderOptions = false;
              });
            },
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
         SizedBox(height: 8),
        Text(
          'Tell us a little about yourself to get started.',
          style: TextStyle(
            fontSize: appSize.mediumText,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required AppSize appSize,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w500,
              color: Colors.black87
          ),
        ),
       5.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),

          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style:  TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1A1A2E),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: appSize.mediumText,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildExpandableField({
    required String label,
    required String hint,
    required String? value,
    required bool isOpen,
    required VoidCallback onTap,
    required List<String> items,
    required Function(String) onSelect,
    required AppSize appSize,

  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        /// 🔹 Main Box
        GestureDetector(
          onTap: onTap,
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
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 16,
                      color: value == null
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),

        /// 🔽 Expand Options
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
            ),
            child: Column(
              children: items.map((item) {
                final isSelected = value == item;

                return InkWell(
                  onTap: () => onSelect(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(item,
                            style:  TextStyle(fontSize: appSize.mediumText, color: isSelected ? Colors.black : Colors.black54),
                          ),
                        ),

                        /// 🔘 Radio UI
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.pink
                                  : Colors.grey,
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
}