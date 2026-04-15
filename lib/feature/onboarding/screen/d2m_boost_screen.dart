import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class D2mBoostScreen extends StatelessWidget {
  const D2mBoostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        titleTextStyle: TextStyle(fontSize: appSize.mediumText),
        title: const Text("Get Boost"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(height: appSize.height*0.05),

               /// Profile Section
               Center(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Stack(
                       alignment: Alignment.bottomRight,
                       children: [
                         Container(
                           height: appSize.height*0.12,
                           width: appSize.height*0.12,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(color: Colors.white,width: 3),
                               image: DecorationImage(
                                   fit: BoxFit.cover,
                                   image:NetworkImage( "https://images.unsplash.com/photo-1494790108377-be9c29b29330",))
                           ),
                           child: CircularProgressIndicator(color: Colors.blue,),
                         ),
                         Container(
                           padding: const EdgeInsets.all(6),
                           decoration:  BoxDecoration(
                               color: Colors.purple.shade100,
                               shape: BoxShape.circle,
                               border: Border.all(color: Colors.white)
                           ),
                           child:  Icon(Icons.rocket_launch_outlined, size: 16,color: Colors.white,),
                         )
                       ],
                     ),
                     const SizedBox(height: 16),
                     Text(
                       "Stand out to\nserious matches",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: appSize.largeText,
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),

               // SizedBox(height: appSize.height*0.02),
             ],
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 1.0,
            snap: true,
            // snapSizes: [0.7, 1.0],
            builder: (context, scrollController) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.width * 0.05),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔥 Drag Handle
                      Center(
                        child: Container(
                          height: 5,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      /// Feature Items
                      featureItem(
                        icon: Icons.trending_up,
                        title: "Get 5x more profile views",
                        subtitle: "Reach a wider audience instantly.",
                        appSize: appSize,
                      ),
                      const SizedBox(height: 20),

                      featureItem(
                        icon: Icons.star_border,
                        title: "Appear at top of recommendations",
                        subtitle: "Stay visible when your matches are active.",
                        appSize: appSize,
                      ),
                      const SizedBox(height: 20),

                      featureItem(
                        icon: Icons.verified_user_outlined,
                        title: "Reach serious & verified profiles",
                        subtitle: "Connect with high-intent individuals.",
                        appSize: appSize,
                      ),

                      const SizedBox(height: 30),

                      /// Pricing Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1 Spotlight",
                                style: TextStyle(
                                  fontSize: appSize.mediumText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.timelapse,
                                          color: Colors.grey.shade700, size: 16),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Per boost lasts 24 hours",
                                        style: TextStyle(
                                            fontSize: appSize.smallText,
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.grey.shade700, size: 16),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Use anytime",
                                        style: TextStyle(
                                            fontSize: appSize.smallText,
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹199",
                                style: TextStyle(
                                  fontSize: appSize.mediumText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Standard Price",
                                style: TextStyle(
                                  fontSize: appSize.smallText,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Offer Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.secondary,width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('5x more profile view',
                                          style: TextStyle(
                                              fontSize: appSize.mediumText)),
                                      Text('₹422',
                                          style: TextStyle(
                                              fontSize: appSize.largeText,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('03',
                                              style: TextStyle(
                                                  fontSize: appSize.largeText,
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(width: 10),
                                          Text('Spotlights',
                                              style: TextStyle(
                                                  fontSize: appSize.mediumText,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Text('SAVE 60%',
                                          style: TextStyle(
                                              fontSize: appSize.smallText,
                                              color: Colors.grey.shade700)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Icon(Icons.timelapse,
                                    color: Colors.grey.shade700, size: 16),
                                const SizedBox(width: 10),
                                Text(
                                  "Per boost lasts 24 hours",
                                  style: TextStyle(
                                      fontSize: appSize.smallText,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    color: Colors.grey.shade700, size: 16),
                                const SizedBox(width: 10),
                                Text(
                                  "Use anytime",
                                  style: TextStyle(
                                      fontSize: appSize.smallText,
                                      color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text("Just ₹422 per boost", style: TextStyle(
                                fontSize: appSize.mediumText,
                                color: Colors.black,fontWeight: FontWeight.w500),)

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
          
          Positioned(
            bottom: 50,
            right: 20,left: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get 3 Spotlights",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: appSize.mediumText),),
                  Icon(Icons.rocket_launch_outlined,size: 18,color: Colors.white,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget featureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required AppSize appSize,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple.shade50,
          child: Icon(icon, color: AppColors.secondary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:  TextStyle(
                      fontSize: appSize.mediumText, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style:  TextStyle(fontSize: appSize.mediumText,color: Colors.grey.shade700),
              ),
            ],
          ),
        )
      ],
    );
  }
}