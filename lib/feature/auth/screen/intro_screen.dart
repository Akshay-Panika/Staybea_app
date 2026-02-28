import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../verification/screen/verification_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final  titles = [
    {
      "img": "assets/intro/intro1.gif",
      "title": "Welcome to Staybea",
      "description": "find your true life partner , follow our rules to make every step genuine ",
    },
    {
      "img": "assets/intro/intro2.gif",
      "title": "Strat Your Love Life Journey Today",
      "description": "felling alone don't just charge your phone use it make your love connection   ",
    },
    {
      "img": "assets/intro/intro3.gif",
      "title": "Date and make your love moments",
      "description": "start dating with trusted and genuine person , make your love moments ",
    },
    {
      "img": "assets/intro/intro4.gif",
      "title": "build your happy relationship heartline",
      "description": "make your life long relationship heartline that stay with you",
    },

  ];

  void nextPage() {
    if (currentIndex < titles.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToVerification();
    }
  }


  void skip() {
    goToVerification();
  }

  void goToVerification() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const VerificationScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xFFFFEAFF),
            Color(0xFFFFFFFF)
          ])
        ),
        child: Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.only(top: 60),
              child:  Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: AssetImage(
                            titles[currentIndex]['img'].toString(),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: titles.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final introData =  titles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                    child: Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            introData['title'].toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            // style: const TextStyle(
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.w700,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        Text(introData['description'].toString(),
                          style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 16),textAlign: TextAlign.center,),
                        SizedBox(height: 30,),
                        if(index  == 0)
                        Column(
                          spacing: 30,
                          children: [
                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Verification',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                Text('verify all necessary document that insured your trust and genuine presence while finding an match',
                                style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600),)
                              ],
                            ),
                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Genuine',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                Text('be genuine while finding your life partner match Respect others.',
                                  style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600),)
                              ],
                            )
                          ],
                        )

                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                titles.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 4,
                  width: currentIndex == index ? 50 : 30,
                  decoration: BoxDecoration(
                    color:currentIndex == index ? Color(0xFFA54275):Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                spacing: 10,
                children: [

                  if (currentIndex > 0)
                    GestureDetector(
                    onTap: skip,
                    child: Container(
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration:  BoxDecoration(
                            color: Color(0xFFA54275),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text("Skip", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),))
                    ),
                  ),



                  Expanded(
                    child: GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        height: 55,
                        decoration:  BoxDecoration(
                          color: Color(0xFFA54275),
                         borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text(
                          currentIndex > 0 ? "Next" : "I Agree",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),))
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
