import 'package:flutter/material.dart';
import '../../../core/constant/App_color.dart';
import '../../../core/utils/app_size.dart';

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


class MatureConnectionProfile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final String heroTag;

  const MatureConnectionProfile({
    super.key,
    required this.profile,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    final List images = profile['images'];

    return Scaffold(
      appBar: AppBar(toolbarHeight: 10,backgroundColor: Colors.white,),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Hero(
                        tag: heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            images[0],
                            height: 650,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16,left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🔥 Name + Match %
                                  Row(
                                    children: [
                                      // 🟢 Online Dot
                                      Container(
                                        width: 8,
                                        height: 8,
                                        margin: const EdgeInsets.only(right: 6),
                                        decoration: BoxDecoration(
                                          color: profile['isOnline'] ? Colors.green : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),

                                      // Name + Age
                                      Text(
                                        "${profile['name']} ${profile['age']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      10.width,

                                      Container(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          spacing: 10,
                                          children: [
                                            Icon(Icons.verified,color: Colors.blue,size: 16,),
                                            Text(
                                              "${profile['matchPercent']}%",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 6),

                                  // // 📏 Height + Community
                                  // Text(
                                  //   "${profile['height']} • ${profile['community']}",
                                  //   style: const TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.w500
                                  //   ),
                                  // ),

                                  // const SizedBox(height: 6),

                                  // 📍 Location + Distance
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.white, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${profile['location']} • ${profile['rangeKM']} away",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),

                                  // const SizedBox(height: 6),

                                  // 💼 Profession
                                  Row(
                                    children: [
                                      const Icon(Icons.search,
                                          color: Colors.white, size: 16),
                                      const SizedBox(width: 4),
                                      Text('Looking for Life Partner',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 8),
                    _aboutCard(appSize),
                    _basicDetails(appSize),
                    _hobbiesInterestsCard(appSize),
                    _photoLibraryCard(appSize),
                    _compatibilityCard(appSize),
                    _educationCareer(appSize),
                    _financialSituation(appSize),
                    _familyDetails(appSize),
                    _dreamsCard(appSize),
                    _healthCard(appSize),
                    const SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back, color: Colors.black,)),),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(onPressed: () {
                    _showMoreOptionsSheet(context);
                  }, icon: Icon(Icons.more_vert, color: Colors.black,)),),

              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.secondary)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.favorite_border, color: Color(0xFFAC4870)),
                            SizedBox(width: 6),
                            Text(
                              "Super Connect",
                              style: TextStyle(
                                color: Color(0xFFAC4870),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.favorite, color: Colors.white),
                            SizedBox(width: 6),
                            Text(
                              "Send Like",
                              style: TextStyle(
                                color: Colors.white,
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
          )        ],
      ),
    );
  }
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
      ],
    ),
  );
}
Widget _basicDetails(AppSize appSize) {
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
                _GreyChip(label: 'Managed by myself'),
                _GreyChip(label: 'ID SB67584945'),
                _GreyChip(label: ' 61 yrs old'),
                _GreyChip(label: " Height - 5'8\""),
              ],
            ),
            const SizedBox(height: 20),
            _TwoColRow(
              left: _DetailItem(
                label: "Birth date",
                icon: Icons.calendar_today_outlined,
                value: '19-02-1962',                        // ✅ fixed date
              ),
              right: _DetailItem(
                label: "Gender",
                icon: Icons.person_outline,
                value: 'Women',
              ),
            ),

            _TwoColRow(
              left: _DetailItem(
                label: "Religion",
                icon: Icons.temple_hindu_outlined,          // ✅ added
                value: 'Hindu',
              ),
              right: _DetailItem(
                label: "Community",
                icon: Icons.groups_outlined,                // ✅ added
                value: 'Deshast Brahmin',
              ),
            ),

            _TwoColRow(
              left: _DetailItem(
                label: "Diet Preferences",
                icon: Icons.restaurant_outlined,            // ✅ added
                value: 'Vegetarian',
              ),
              right: _DetailItem(
                label: "Sunsign",
                icon: Icons.auto_awesome_outlined,
                value: 'Scorpio',
              ),
            ),

            _TwoColRow(
              left: _DetailItem(
                label: "Lives in",
                icon: Icons.location_on_outlined,
                value: 'Pune',
              ),
              right: _DetailItem(
                label: "Marital Status",
                icon: Icons.favorite_border_outlined,       // ✅ added
                value: 'Widowed',
              ),
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
                value: 'Compliments',
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
        _divider(),
      ],
    ),
  );
}Widget _educationCareer(AppSize appSize){
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
                label: "Profession",
                icon: Icons.school_outlined,
                value: 'Fashion Designer',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Highest Qualification",
                icon: Icons.shopping_bag_outlined,
                value: 'M.Des ',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Education Field",
                icon: Icons.school_outlined,
                value: 'Commerce',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Collage name",
                icon: Icons.shopping_bag_outlined,
                value: 'NIFT',
              ),
              right: null,
            ),
          ],
        ),
        _divider(),

      ],
    ),
  );
}
Widget _financialSituation(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Financial Situation',
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
                label: "Income Source",
                icon: Icons.shopping_bag_outlined,
                value: 'Pension',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Pension Type",
                icon: Icons.home_outlined,
                value: 'Government Pension',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Work Field",
                icon: Icons.school_outlined,
                value: 'Education',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Monthly Income",
                icon: Icons.currency_rupee,
                value: '₹50,000 ',
              ),
              right: null,
            ),
          ],
        ),
        _divider(),

      ],
    ),
  );
}
Widget _familyDetails(AppSize appSize) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Title
        Center(
          child: Text(
            'Family Details',
            style: TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 10),
        _divider(),
        const SizedBox(height: 12),

        /// 👨 Son
        _familyItem(
          icon: Icons.male,
          title: 'Son • Rahul',
          subtitle: 'Software Engineer • Bangalore',
        ),

        const SizedBox(height: 12),

        /// 👩 Daughter
        _familyItem(
          icon: Icons.female,
          title: 'Daughter • Anjali',
          subtitle: 'Marketing Lead • Mumbai',
        ),

        const SizedBox(height: 16),

        /// Description
        Text(
          'Children are well-settled and supportive. '
              'Now looking for peaceful companionship with someone who values family.',
          style: TextStyle(
            fontSize: appSize.smallText,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}
Widget _familyItem({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// Icon
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFFCE4EC),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFFAC4870), size: 18),
      ),

      const SizedBox(width: 10),

      /// Texts
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),

      /// Badge
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          'Married',
          style: TextStyle(
            fontSize: 11,
            color: Colors.black54,
          ),
        ),
      ),
    ],
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

      ],
    ),
  );
}
Widget _dreamsCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Dreams & Future Plans',
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
            _InterestChip(emoji: '🍳', label: 'Start a small business'),
            _InterestChip(emoji: '🎬', label: 'Spiritual travel'),
            _InterestChip(emoji: '📷', label: 'Volunteer work'),
          ],
        ),
      ],
    ),
  );
}
Widget _healthCard(AppSize appSize){
  return _card(
    child: Column(
      spacing: 16,
      children: [
        Text(
          'Health & Wellness',
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
                label: "Workout",
                icon: Icons.shopping_bag_outlined,
                value: 'Often',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Health Condition",
                icon: Icons.home_outlined,
                value: 'Minor health condition',
              ),
              right: null,
            ),
            _TwoColRow(
              left: _DetailItem(
                label: "Type of Condition",
                icon: Icons.school_outlined,
                value: 'Blood Pressure',
              ),
              right: null,
            ),

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

void _showMoreOptionsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            _moreOptionTile(
              context,
              icon: Icons.share_outlined,
              label: "Share Profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: share logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.star_border_outlined,
              label: "Add to shortlist",
              onTap: () {
                Navigator.pop(context);
                // TODO: shortlist logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.visibility_off_outlined,
              label: "Hide this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: hide logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.block_outlined,
              label: "Block this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: block logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.warning_amber_outlined,
              label: "Report this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: report logic
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

Widget _moreOptionTile(
    BuildContext context, {
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.black54),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}