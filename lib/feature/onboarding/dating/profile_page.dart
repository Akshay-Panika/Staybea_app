import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';
const kPink = Color(0xFFE8637A);
const kPinkLight = Color(0xFFFFF0F2);
const kPinkBorder = Color(0xFFFFD6DC);
const kBg = Color(0xFFF7F7F7);
const kCardBg = Colors.white;
const kTextDark = Color(0xFF1A1A1A);
const kTextGrey = Color(0xFF888888);
const kTextLight = Color(0xFFBBBBBB);
const kDivider = Color(0xFFF0F0F0);

// Random Unsplash images
const _imgWoman1 =
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=600&q=80';
const _imgWoman2 =
    'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=600&q=80';
const _imgWoman3 =
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&q=80';
const _imgWoman4 =
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80';
const _imgCafe =
    'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=600&q=80';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 8),

              _lookingCard(appSize),
              _aboutCard(appSize),
              _quickInfoCard(appSize),
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: _personalFavCard(
                      imageUrl: _imgWoman1,
                      label: 'This one is my personal fav.',
                      height: appSize.height*0.4,
                    ),
                  ),
                  
                  Icon(Icons.play_circle_outline, color: Colors.white,size: appSize.height*0.06,)
                ],
              ),
              _basicDetails(appSize),
              _educationCareer(appSize),

              // ── Guess Photo ──
              _personalFavCard(
                imageUrl: _imgCafe,
                label: 'Guess how many takes this took.',
                height: appSize.height*0.45,
              ),

              // ── Hobbies & Interests ──
              _educationCareer(appSize),
              _hobbiesInterestsCard(appSize),
              _lifestyleCard(appSize),
              _personalFavCard(
                imageUrl: _imgWoman2,
                label: 'Get someone who looks at you like.',
                height: appSize.height*0.4,
              ),
              _compatibilityCard(appSize),
              _photoLibraryCard(appSize),

              _profileActions("Shraddha"),
            ],
          ),


        ],
      ),
    );
  }
}




class _FooterLink extends StatelessWidget {
  final String label;
  final Color color;
  const _FooterLink({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(label,
          style: TextStyle(
              fontSize: 13,
              color: color,
              decoration: TextDecoration.underline,
              decorationColor: color.withOpacity(0.4))),
    );
  }
}

Widget _lookingCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 14,
      children: [
         Text(
          'Looking For',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),

        Row(
          spacing: 10,
          children: [
            Icon(Icons.person_2, color: AppColors.secondary,),
            Text("New Friends", style: TextStyle(fontWeight: FontWeight.w400,fontSize: appSize.mediumText),)
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),)
          ],
        ),
      ],
    ),
  );
}
Widget _aboutCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 14,
      children: [
         Text(
          'About me',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),

        Row(
          spacing: 10,
          children: [
            Expanded(child: Text("Calm, positive person who enjoys gardening, music, and good conversations. Looking for someone to share simple happy moments with", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),))
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text("View more", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),
            Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.secondary,),

          ],
        ),
      ],
    ),
  );
}
Widget _quickInfoCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
         Text(
          'A quick intro from me.',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                  color: kPink, shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomPaint(
                size: const Size(double.infinity, 30),
                painter: _WaveformPainter(),
              ),
            ),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
class _WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final activePaint = Paint()
      ..color = kPink
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;
    final inactivePaint = Paint()
      ..color = kPinkBorder
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    const bars = [
      0.25, 0.6, 0.4, 0.9, 0.5, 0.75, 0.35, 1.0, 0.55, 0.7,
      0.3,  0.65, 0.8, 0.45, 0.95, 0.6, 0.5, 0.75, 0.3, 0.85,
      0.5,  0.7, 0.4, 0.6, 0.35, 0.75, 0.5, 0.9, 0.55, 0.4,
      0.65, 0.8, 0.45, 0.7, 0.35,
    ];

    final spacing = size.width / (bars.length * 2 - 1);
    const activeUntil = 15;

    for (int i = 0; i < bars.length; i++) {
      final x = i * spacing * 2;
      final h = bars[i] * size.height;
      final top = (size.height - h) / 2;
      canvas.drawLine(
        Offset(x, top),
        Offset(x, top + h),
        i < activeUntil ? activePaint : inactivePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) => false;
}
Widget _personalFavCard({
  final String? imageUrl,
  final String? label,
  final double? height,}){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    height: height,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            imageUrl!,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return child;
              return Container(
                  height: height,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(18)),
                  child: const Center(
                      child: CircularProgressIndicator(
                          color: kPink, strokeWidth: 2)));
            },
          ),
        ),
        // Gradient
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.45),
                ],
                stops: const [0.0, 0.25, 0.65, 1.0],
              ),
            ),
          ),
        ),
        // Label
        Positioned(
          top: 14,
          left: 16,
          right: 70,
          child: Text(label!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: Offset(0, 1))
                  ])),
        ),
        // Reply
        Positioned(
          bottom: 12,
          right: 14,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.reply_outlined,
                size: 14, color: Colors.white),
            label: const Text('Reply',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white70, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget _basicDetails(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Basic details',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _GreyChip(label: '🎂  22 yrs old'),
                _GreyChip(label: "📏  Height - 5'8\""),
              ],
            ),
            const SizedBox(height: 20),
            _TwoColRow(
              left: _DetailItem(
                  label: "Birth date",
                  icon: Icons.calendar_today_outlined,
                  value: '13-01-1962'),
              right: _DetailItem(
                  label: "Gender",
                  icon: Icons.person_outline, value: 'Women'),
            ),

            _TwoColRow(
              left: _DetailItem(
                 label: "Communication",
                  icon: Icons.phone_outlined,
                  value: 'Phone caller',
              ),
              right: _DetailItem(
                  label: "Love Style",
                  icon: Icons.card_giftcard_outlined,
                  value: 'Compliments'),
            ),

            _TwoColRow(
              left: _DetailItem(
                  label: "Sunsign",
                  icon: Icons.auto_awesome_outlined,
                  value: 'Scorpio'),
              right: _DetailItem(
                  label: "Lives in",
                  icon: Icons.location_on_outlined,
                  value: 'Pune'),
            ),
            const SizedBox(height: 20),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
Widget _educationCareer(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Education & Career',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Column(
          children: [
            _TwoColRow(
              left: _DetailItem(
                label: "Education",
                icon: Icons.school_outlined,
                value: 'At University',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Occupation",
                icon: Icons.shopping_bag_outlined,
                value: 'Student',
              ),
              right: null,
            ),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
class _GreyChip extends StatelessWidget {
  final String label;
  const _GreyChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
      Text(label, style: const TextStyle(fontSize: 12, color: kTextDark)),
    );
  }
}
class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.secondary), // Icon part
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class _TwoColRow extends StatelessWidget {
  final _DetailItem? left;
  final _DetailItem? right;

  const _TwoColRow({this.left, this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: left ?? const SizedBox.shrink()),

          Expanded(child: right ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
Widget _hobbiesInterestsCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Hobbies & Interests',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _InterestChip(emoji: '✈️', label: 'Travelling'),
            _InterestChip(emoji: '🎬', label: 'Movies'),
            _InterestChip(emoji: '📷', label: 'Photography'),
            _InterestChip(emoji: '🥾', label: 'Trekking'),
            _InterestChip(emoji: '🍳', label: 'Cooking'),
            _InterestChip(emoji: '🏖️', label: 'Travelling'),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
class _InterestChip extends StatelessWidget {
  final String emoji;
  final String label;
  const _InterestChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary,width: 0.6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(label,
              style:  TextStyle(fontSize: 14, color: kTextDark)),
        ],
      ),
    );
  }
}
Widget _lifestyleCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Lifestyle',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Column(
          children: [
            _TwoColRow(
              left: _DetailItem(
                label: "Drinking",
                icon: Icons.local_bar_outlined, // Martini/Cocktail glass
                value: 'Socially, at the weekend',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Smoking",
                icon: Icons.smoking_rooms_outlined, // Smoking icon
                value: 'Non-smoker',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Exercise",
                icon: Icons.fitness_center_outlined, // Dumbbell icon
                value: 'Sometimes',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Pets",
                icon: Icons.pets_outlined, // Paw print icon
                value: 'Dogs',
              ),
              right: null,
            ),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
Widget _compatibilityCard(AppSize appSize){
  final List<Map<String, String>> _items = const [
    {
      "title": "I Want someone who",
      "subtitle": "Understand my feelings",
    },
    {
      "title": "I'm looking for",
      "subtitle": "A travel partner",
    },
  ];
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
               "Long term compatibility",
               style: TextStyle(
                 fontSize: appSize.mediumText,
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
               ),
             ),
            SizedBox(
              height: appSize.height*0.16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: appSize.width*0.7, // Width of each card
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8EF), // Light pink background
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFC2467C), // Dark pink/purple border
                        width: 0.8,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "“ ${_items[index]['title']}",
                          style:  TextStyle(
                            fontSize: appSize.mediumText,
                            color: Colors.black54,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _items[index]['subtitle']!,
                          style:  TextStyle(
                            fontSize: appSize.mediumText,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
Widget _photoLibraryCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Photo Library',
          style: TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        _divider(),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    _imgWoman3,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, prog) {
                      if (prog == null) return child;
                      return Container(
                          height: 200,
                          color: const Color(0xFFE0E0E0),
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: kPink,
                                  strokeWidth: 2)));
                    },
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.88),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow,
                      color: kTextDark, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _LibraryThumb(url: _imgWoman1),
                const SizedBox(width: 6),
                _LibraryThumb(url: _imgWoman4),
                const SizedBox(width: 6),
                _LibraryThumb(url: _imgCafe),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final active = i == 0;
                return Container(
                  width: active ? 18 : 6,
                  height: 6,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: active ? kPink : kTextLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ],
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.favorite_border, color: AppColors.secondary,),
            Text("Reply", style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: appSize.mediumText),),

          ],
        ),
      ],
    ),
  );
}
class _LibraryThumb extends StatelessWidget {
  final String url;
  const _LibraryThumb({required this.url});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          height: 88,
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, prog) {
            if (prog == null) return child;
            return Container(
                height: 88,
                color: const Color(0xFFE0E0E0),
                child: const Center(
                    child:
                    CircularProgressIndicator(color: kPink, strokeWidth: 1.5)));
          },
        ),
      ),
    );
  }
}


Widget _divider(){
  return Container(
    height: 2,
    margin: const EdgeInsets.symmetric(horizontal: 30),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.transparent,
          // Color(0xFFF0E1EC), // Light pinkish-purple
          Color(0xFF9D4488), // Main purple
          // Color(0xFFF0E1EC),
          Colors.transparent,
        ],
      ),
    ),
  );
}
Widget _card({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white, // Essential: BoxDecoration needs a color to show shadows
      borderRadius: BorderRadius.circular(12), // Smoother rounded corners
      border: Border.all(
        color: Colors.grey.shade300, // A light, subtle border
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05), // Very soft shadow
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 4), // Move shadow down slightly
        ),
      ],
    ),
    child: child,
  );
}
Widget _profileActions(String name) {
  return Column(
    children: [
      _card(
        child: Row(
          children: [
            // Message Button
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFAA4A74), // Muted plum/wine color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Send Like Button
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF2FD), // Very light blue
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: Color(0xFFAA4A74), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Send Like",
                        style: TextStyle(
                          color: Color(0xFFAA4A74),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // 2. Share Profile
      _actionButton("Share $name's profile", Colors.black87),

      // 3. Block Profile
      _actionButton("Block $name", Colors.black87),

      // 4. Report Profile
      _actionButton("Report $name", Colors.red),
    ],
  );
}

Widget _actionButton(String title, Color textColor) {
  return _card(
    child: Center(
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
