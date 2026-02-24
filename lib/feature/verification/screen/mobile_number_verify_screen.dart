import 'package:flutter/material.dart';

import 'otp_verify_screen.dart';

class MobileNumberVerifyScreen extends StatelessWidget {
  const MobileNumberVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
             Row(
               children: [
                 InkWell(
                   onTap: () {
                     Navigator.pop(context);
                   },
                   child: Container(
                     padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: Colors.grey)
                     ),
                     child: Row(
                       spacing: 10,
                       children: [
                         Icon(Icons.arrow_back),
                         Text('Back', style: TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.w500),)
                       ],
                     ),
                   ),
                 ),
               ],
             ),
            SizedBox(height: 20,),

            Text('Fill Your Mobile Number we connect you with your dating partner .',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
            SizedBox(height: 40,),

            Row(
              spacing: 10,
              children: [
                Column(
                  spacing:10,
                  children: [
                    const Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 50,
                      color: Colors.grey,
                    ),
                  ],
                ),



                Expanded(
                  child: Column(
                    spacing:10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),

                          border: InputBorder.none,

                          // 👇 remove ALL internal space
                          isCollapsed: true,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),



                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            
            Text('we’ll text you a code to verify you’re really you. Message and data rate may apply. Verifying you mobile number',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),),
            
            Spacer(),
            
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerifyScreen(),));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFA54275),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text('Verify Number',style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w500),)),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
