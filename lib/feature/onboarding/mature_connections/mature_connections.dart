import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_button.dart';
import 'package:staybea_app/feature/dashboard/screen/dashboard_screen.dart';
import 'package:staybea_app/feature/onboarding/your_intereste_for_date/screen/your_intereste_for_date_screen.dart';
import '../../../core/constant/App_color.dart';
import '../yoor_yourself/screen/your_yourself_screen.dart';
import '../your_photos/screen/your_photos_screen.dart';
import '../your_selfie/screen/your_selfie_screen.dart';
import '../your_verify_profile/screen/your_verify_profile.dart';
import '../you_education/screen/your_education_screen.dart';
import '../you_self_screen/screen/your_self_screen.dart';
import '../your_location/screen/your_location_screen.dart';
import '../your_profile/screen/your_profile_screen.dart';
import '../your_religion/screen/your_religion_screen.dart';
import '../your_dream_plan/screen/dream_plan_screen.dart';
import '../your_financial/screen/your_financial.dart';
import '../your_health/screen/your_health_screen.dart';
import '../your_hobby/screen/your_hobbies_screen.dart';
import '../your_lifestyle/screen/your_lifestyle_screen.dart';

class MatureConnections extends StatefulWidget {
  const MatureConnections({super.key});

  @override
  State<MatureConnections> createState() => _MatureConnectionsState();
}

class _MatureConnectionsState extends State<MatureConnections> {
  // ✅ REMOVED: ScrollController
  int _currentStep = 0;

  List<Widget> get _steps => [
    YourProfileScreen(),
    YourInteresteForDateScreen(),
    YourReligionScreen(),
    YourLocationScreen(),
    YourSelfScreen(),
    YourEducationScreen(),
    YourFinancialScreen(),
    YourLifestyleScreen(),
    YourHealthScreen(),
    YourHobbiesScreen(),
    DreamPlanScreen(),
    YourPhotosScreen(),
    YourYourselfScreen(),
    YourVerifyProfile(),
    YourSelfieScreen(),
  ];

  // ✅ FIXED: No animateTo
  void _goToStep(int step) {
    setState(() => _currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              /// Progress Indicator
              LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth - 20;
                  final segmentWidth = totalWidth / _steps.length;

                  return Row(
                    children: List.generate(_steps.length, (index) {
                      final isActive = index <= _currentStep;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                        height: 4,
                        width: segmentWidth,
                        color: isActive
                            ? AppColors.secondary
                            : Colors.grey.shade200,
                      );
                    }),
                  );
                },
              ),

              SizedBox(height: appSize.height * 0.02),

              /// Back + Skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back
                  InkWell(
                    onTap: () {
                      if (_currentStep == 0) {
                        Navigator.pop(context);
                      } else {
                        _goToStep(_currentStep - 1);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios,
                              size: appSize.mediumText, color: Colors.grey),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: appSize.mediumText,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Skip
                  InkWell(
                    onTap: () {
                      if (_currentStep < _steps.length - 1) {
                        _goToStep(_currentStep + 1);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DashboardScreen()),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: appSize.mediumText,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: appSize.height * 0.02),

              /// Step Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _steps[_currentStep],
                ),
              ),

              /// Next / Finish Button
              AppButton(
                onTap: () {
                  if (_currentStep < _steps.length - 1) {
                    _goToStep(_currentStep + 1);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => DashboardScreen()),
                    );
                  }
                },
                text: _currentStep == _steps.length - 1 ? "Finish" : "Next",
                tColor: Colors.white,
                bColor: AppColors.secondary,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}