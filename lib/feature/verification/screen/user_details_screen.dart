import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import '../../dashboard/screen/dashboard_screen.dart';
import '../user_details_stape/about_yourself_widget.dart';
import '../user_details_stape/dob_step_widget.dart';
import '../user_details_stape/gender_step_widget.dart';
import '../user_details_stape/interesting_step_widget.dart';
import '../user_details_stape/latest_photos_widget.dart';
import '../user_details_stape/lifestyle_widget.dart';
import '../user_details_stape/looking_step_widget.dart';
import '../user_details_stape/matters_widget.dart';
import '../user_details_stape/name_step_widget.dart';
import '../user_details_stape/person_studying_widget.dart';
import '../user_details_stape/profile_step_widget.dart';
import '../user_details_stape/searching_distance_widget.dart';
import '../user_details_stape/sexual_step_widget.dart';


class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final ScrollController _progressController = ScrollController();
  int _currentStep = 0;

  List<Widget> get _steps => [
    InterestingStepWidget(),
    ProfileSetupWidget(),
    // DobStepWidget(),
    // GenderStepWidget(),
    // SexualStepWidget(),
    // LookingStepWidget(),
    // SearchingDistanceWidget(),
    // PersonStudyingWidget(),
    LifestyleWidget(),
    MattersWidget(),
    LatestPhotosWidget(),
    AboutYourselfWidget(),
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
    return Scaffold(
       backgroundColor: Colors.white,
      // backgroundColor: Color(0xffF7F8FA),
      body: SafeArea(
        child: Column(
          children: [

            /// progress
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                controller: _progressController,
                itemCount: _steps.length,
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final isActive = index <= _currentStep;

                  return Row(
                    children: [
                      if (index != 0)
                        AnimatedContainer(
                          duration:  Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          height: 4,
                          width: 40,
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
              padding: const EdgeInsets.all(16),
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
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
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
            InkWell(
              onTap: () {
                if (_currentStep < _steps.length - 1) {
                  _goToStep(_currentStep + 1);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileStepWidget()),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54275),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  Widget _buildNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Icon(Icons.star, size: 32, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                "What's your name?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TEXTFIELD
          TextField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Your Name",
              isDense: true,                 // height kam
              contentPadding: EdgeInsets.zero, // padding remove
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// UNDERLINE
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 18),

          /// DESCRIPTION
          const Text(
            "Decide what your partner should call you",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


}


class StayBeaScreen extends StatelessWidget {
  const StayBeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 16),
              // Subtitle
              const Text(
                'See more students at your university and nearby',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Primary button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA54275),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Let’s do it",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              // Secondary button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey,width: 0.3)
                  ),
                  child: const Center(
                    child: Text(
                      "No Thanks",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}