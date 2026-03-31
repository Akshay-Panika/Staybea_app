import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  DateTime? _selectedDate;
  String? _selectedHeight;
  String? _selectedGender;
  bool _showHeightOptions = false;
  bool _showGenderOptions = false;

  final List<String> _heights = [
    'Below 5\'0"', '5\'0"', '5\'1"', '5\'2"', '5\'3"', '5\'4"',
    '5\'5"', '5\'6"', '5\'7"', '5\'8"', '5\'9"', '5\'10"',
    '5\'11"', '6\'0"', '6\'1"', '6\'2"', 'Above 6\'2"',
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
          _buildExpandableField(
            label: 'Height',
            hint: 'Select Height',
            value: _selectedHeight,
            isOpen: _showHeightOptions,
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


  Widget _buildExpandableField({
    required String label,
    required String hint,
    required String? value,
    required bool isOpen,
    required VoidCallback onTap,
    required List<String> items,
    required Function(String) onSelect,
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
                      fontSize: 15,
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
                            style:  TextStyle(fontSize: 16, color: isSelected ? Colors.black : Colors.black54),
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

        GestureDetector(
          onTap: () async {
            DateTime now = DateTime.now();

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(now.year - 18), // default 18 age
              firstDate: DateTime(1950),
              lastDate: DateTime(now.year - 18),
            );

            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;

                // optional: fill controllers if you still want values
                _dayController.text =
                    pickedDate.day.toString().padLeft(2, '0');
                _monthController.text =
                    pickedDate.month.toString().padLeft(2, '0');
                _yearController.text = pickedDate.year.toString();
              });
            }
          },

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
                    _selectedDate == null
                        ? "Select your DOB"
                        : "${_selectedDate!.day.toString().padLeft(2, '0')}/"
                        "${_selectedDate!.month.toString().padLeft(2, '0')}/"
                        "${_selectedDate!.year}",
                    style: TextStyle(
                      fontSize: 15,
                      color: _selectedDate == null
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey)
              ],
            ),
          ),
        ),
      ],
    );
  }
}