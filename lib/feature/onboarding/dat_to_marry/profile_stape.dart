import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileStep extends StatefulWidget {
  const ProfileStep({super.key});

  @override
  State<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends State<ProfileStep>

    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedHeight;
  String? _selectedGender;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final List<String> _heights = [
    'Below 5\'0"', '5\'0"', '5\'1"', '5\'2"', '5\'3"', '5\'4"',
    '5\'5"', '5\'6"', '5\'7"', '5\'8"', '5\'9"', '5\'10"',
    '5\'11"', '6\'0"', '6\'1"', '6\'2"', 'Above 6\'2"',
  ];

  final List<String> _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 36),
          _buildInputField(
            label: 'Full Name',
            controller: _nameController,
            hint: 'Enter your full name',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            label: 'Email Id',
            controller: _emailController,
            hint: 'Enter your email',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildDOBField(),
          const SizedBox(height: 20),
          _buildDropdownField(
            label: 'Height',
            hint: 'Select Height',
            icon: Icons.straighten_rounded,
            value: _selectedHeight,
            items: _heights,
            onChanged: (val) => setState(() => _selectedHeight = val),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            label: 'Select Gender',
            hint: 'Your Gender',
            icon: Icons.wc_rounded,
            value: _selectedGender,
            items: _genders,
            onChanged: (val) => setState(() => _selectedGender = val),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's set up your profile.",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tell us a little about yourself to get started.',
          style: TextStyle(
            fontSize: 14,
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.04),
            //     blurRadius: 5,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A2E),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 15,
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

  Widget _buildDOBField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDateBox(controller: _dayController, hint: 'DD', maxLength: 2),
            const SizedBox(width: 10),
            _buildDateBox(controller: _monthController, hint: 'MM', maxLength: 2),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _buildDateBox(
                controller: _yearController,
                hint: 'YYYY',
                maxLength: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateBox({
    required TextEditingController controller,
    required String hint,
    required int maxLength,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
          // border: Border.all(color: const Color(0xFFE8E8E8), width: 1.5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.04),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: maxLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            counterText: '',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.04),
            //     blurRadius: 8,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Row(
                children: [
                  Icon(icon, color: Colors.grey.shade400, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    hint,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(14),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}