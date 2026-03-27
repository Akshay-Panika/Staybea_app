import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class FinancialSituation extends StatefulWidget {
  const FinancialSituation({super.key});

  @override
  State<FinancialSituation> createState() => _FinancialSituationState();
}

class _FinancialSituationState extends State<FinancialSituation> {
  String? _selectedIncomeSource;
  final TextEditingController _incomeController = TextEditingController();

  final List<String> _incomeSources = [
    'Salaried Employee',
    'Self Employed',
    'Business Owner',
    'Freelancer',
    'Student',
    'Retired',
    'Homemaker',
    'Not Employed',
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
                      "Income Source",
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
                  itemCount: _incomeSources.length,
                  itemBuilder: (_, index) {
                    final option = _incomeSources[index];
                    final isSelected = option == _selectedIncomeSource;
                    return InkWell(
                      onTap: () {
                        setState(() => _selectedIncomeSource = option);
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
  void dispose() {
    _incomeController.dispose();
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
            "Financial Situation",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Income Source label
          const Text(
            "Income Source",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Income Source dropdown
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
                    _selectedIncomeSource ?? "Select your source",
                    style: TextStyle(
                      fontSize: 14,
                      color: _selectedIncomeSource != null
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

          // Annual Income label
          const Text(
            "Annual Income (Optional)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Annual Income text field
          TextField(
            controller: _incomeController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: "Enter your annual income",
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