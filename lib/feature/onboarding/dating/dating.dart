import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_button.dart';
import 'package:staybea_app/feature/dashboard/screen/dashboard_screen.dart';
import 'package:staybea_app/feature/onboarding/dat_to_marry/talk_lifestyle.dart';
import 'package:staybea_app/feature/onboarding/dat_to_marry/take_a_selfie.dart';
import 'package:staybea_app/feature/onboarding/dat_to_marry/you_love.dart';
import 'package:staybea_app/feature/onboarding/dat_to_marry/you_matters.dart';
import '../../../core/constant/App_color.dart';
import '../dat_to_marry/about_yourself.dart';
import '../dat_to_marry/latest_photos.dart';
import '../dat_to_marry/seeing_for_a_date.dart';
import '../dat_to_marry/verify_your_profile.dart';
import '../your_location/screen/your_location_screen.dart';
import '../your_profile/screen/your_profile_screen.dart';


class Dating extends StatefulWidget {
  const Dating({super.key});

  @override
  State<Dating> createState() => _DatingState();
}

class _DatingState extends State<Dating> {
  final ScrollController _progressController = ScrollController();
  int _currentStep = 0;

  List<Widget> get _steps => [
    YourProfileScreen(),
    YourLocationScreen(),
    SeeingForADate(),
    // MoreAboutYourself(),
    // YourEducation(),
    TalkLifestyle(),
    YouMatters(),
    YouLove(),
    LatestPhotos(),
    AboutYourself(),
    VerifyYourProfile(),
    TakeASelfie(),
  ];

  void _goToStep(int step) {
    setState(() => _currentStep = step);

    // auto scroll to active step
    _progressController.animateTo(
      step * 40, // approx item width
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xffF7F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Container(
                height: 4,
                color: Colors.grey.shade200,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  controller: _progressController,
                  itemCount: _steps.length,
                  scrollDirection: Axis.horizontal,
                  // padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final isActive = index <= _currentStep;

                    return Row(
                      children: [
                        // if (index != 0)
                        AnimatedContainer(
                            duration:  Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                            height: 4,
                            width: 50,
                            color: isActive
                                ? AppColors.secondary
                                :Colors.grey.shade100
                          // : const Color(0xFFEEAECF),
                        ),
                        // AnimatedContainer(
                        //   duration: const Duration(milliseconds: 350),
                        //   curve: Curves.easeInOut,
                        //   child: CircleAvatar(
                        //     radius: 12,
                        //     backgroundColor: isActive
                        //         ? AppColors.secondary
                        //         : Colors.grey.withOpacity(0.16),
                        //     child: Text(
                        //       "${index + 1}",
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: isActive ? Colors.white : Colors.black54,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ),

              /// back
              Padding(
                padding:  EdgeInsets.all(16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (_currentStep == 0) {
                          Navigator.pop(context);
                        } else {
                          _goToStep(_currentStep - 1);
                        }
                      },
                      child: Container(
                        padding:  EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back_ios,size: appSize.mediumText,color: Colors.grey,),
                            // const SizedBox(width: 10),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// STEP CONTENT (scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _steps[_currentStep],
                ),
              ),

              /// next button
              // CustomButton(
              //     onTap: () {
              //       if (_currentStep < _steps.length - 1) {
              //         _goToStep(_currentStep + 1);
              //       } else {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => DashboardScreen()),
              //         );
              //       }
              //     },
              //     text: "Next",
              //     tColor: Colors.white,
              //     bColor: AppColors.secondary,
              // ),

              CustomButton(
                onTap: () {
                  if (_currentStep < _steps.length - 1) {
                    _goToStep(_currentStep + 1);
                  } else if (_currentStep == _steps.length - 1) {
                    // Optionally show a confirmation or just go to Dashboard
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
