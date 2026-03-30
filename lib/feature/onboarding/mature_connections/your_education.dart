import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class YourEducation extends StatefulWidget {
  const YourEducation({super.key});

  @override
  State<YourEducation> createState() => _YourEducationState();
}

class _YourEducationState extends State<YourEducation> {
  String? _selectedEducation;
  final TextEditingController _collegeController = TextEditingController();

  final List<String> _educationOptions = [
    'High School',
    'Some College',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctoral Degree (PhD)',
    'Professional Degree (MD, JD)',
    'Diploma / Certificate',
    'Other',
  ];

  void _showBottomSheet(BuildContext context) {
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
                    const Text(
                      "Highest Education",
                      style: TextStyle(
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
                  itemCount: _educationOptions.length,
                  itemBuilder: (_, index) {
                    final option = _educationOptions[index];
                    final isSelected = option == _selectedEducation;
                    return InkWell(
                      onTap: () {
                        setState(() => _selectedEducation = option);
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
  void dispose() {
    _collegeController.dispose();
    super.dispose();
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
            "Your Education",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Highest Education label
          const Text(
            "Your highest education",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Education dropdown
          GestureDetector(
            onTap: () => _showBottomSheet(context),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedEducation ?? "Your Religion",
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedEducation != null
                          ? Colors.black87
                          : Colors.grey.shade400,
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // College label
          const Text(
            "College",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // College text field
          TextField(
            controller: _collegeController,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: "College you attended",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}