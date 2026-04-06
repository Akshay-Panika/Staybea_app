import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _aboutMeController = TextEditingController();
  int _charCount = 0;

  final List<String?> _photos = List.filled(6, null);

  static const Color primaryPink = Color(0xFFC0396B);
  static const Color lightGrey = Color(0xFFF0F0F0);
  static const Color borderGrey = Color(0xFFE8E8E8);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _aboutMeController.addListener(() => setState(() => _charCount = _aboutMeController.text.length));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  Future<void> _onPhotoTap(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() => _photos[index] = result.files.single.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEditProfileTab(),
                  const Center(child: Text('Preview')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMediaSection(),
          const SizedBox(height: 24),
          _buildAboutMeSection(),
          const SizedBox(height: 24),
          _buildPromptsSection(),

          // --- Languages Section ---
          _buildSectionHeader('Languages I know', showDot: false),
          _buildSelectionTile(label: 'Add languages', leadingIcon: Icons.translate),

          const SizedBox(height: 24),

          // --- Basic Section ---
          _buildSectionHeader('Basic', showDot: false),
          _buildSelectionTileWithTrailing(label: 'Zodiac', value: 'Scorpio', icon: Icons.wb_sunny_outlined),
          _buildSelectionTileWithTrailing(label: 'Education', value: 'Empty', icon: Icons.school_outlined),
          _buildSelectionTileWithTrailing(label: 'Family plans', value: 'Empty', icon: Icons.child_care_outlined),
          _buildSelectionTileWithTrailing(label: 'Communication style', value: 'Empty', icon: Icons.chat_bubble_outline),
          _buildSelectionTileWithTrailing(label: 'Love style', value: 'Empty', icon: Icons.volunteer_activism_outlined),

          const SizedBox(height: 24),

          // --- Lifestyle Section ---
          _buildSectionHeader('Lifestyle', showDot: false),
          _buildSelectionTileWithTrailing(label: 'Pets', value: 'Scorpio', icon: Icons.pets_outlined),
          _buildSelectionTileWithTrailing(label: 'Drinking', value: 'Empty', icon: Icons.wine_bar_outlined),
          _buildSelectionTileWithTrailing(label: 'Smoking', value: 'Empty', icon: Icons.smoking_rooms_outlined),
          _buildSelectionTileWithTrailing(label: 'Workout', value: 'Empty', icon: Icons.fitness_center_outlined),
          _buildSelectionTileWithTrailing(label: 'Social media', value: 'Empty', icon: Icons.alternate_email_outlined),

          const SizedBox(height: 24),

          // --- School Section ---
          _buildSectionHeader('School'),
          _buildSelectionTile(label: 'Add School', leadingIcon: Icons.school_outlined),

          const SizedBox(height: 24),

          // --- Ask Me About Section ---
          _buildSectionHeader('Ask me about', showDot: false),
          _buildSelectionTileWithTrailing(label: 'Going out', value: 'Empty'),
          _buildSelectionTileWithTrailing(label: 'My Weekends', value: 'Empty'),

          const SizedBox(height: 24),

          // --- Job & Living Section ---
          _buildSectionHeader('Job title', important: true),
          _buildSelectionTile(label: 'Add job title', leadingIcon: Icons.business_center_outlined),
          const SizedBox(height: 24),
          _buildSectionHeader('Company'),
          _buildSelectionTile(label: 'Add company', leadingIcon: Icons.location_city_outlined),
          const SizedBox(height: 24),
          _buildSectionHeader('Living in'),
          _buildSelectionTile(label: 'Add city', leadingIcon: Icons.apartment_outlined),
          const SizedBox(height: 24),
          _buildSectionHeader('Sexual orientation'),
          _buildSelectionTileWithTrailing(label: 'Add Sexual orientation', value: 'Hidden'),

          const SizedBox(height: 24),

          // --- Control Profile (Premium) ---
          Row(
            children: [
              const Text('Control your profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text('Premium', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 12),
          _buildSwitchTile("Don't show my age"),
          _buildSwitchTile("Don't show my distance"),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title, {bool showDot = true, bool important = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          if (showDot) ...[_buildDot(), const SizedBox(width: 8)],
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          if (important) ...[
            const SizedBox(width: 8),
            Text('Important', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ]
        ],
      ),
    );
  }

  Widget _buildSelectionTile({required String label, IconData? leadingIcon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: borderGrey, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 22, color: Colors.grey),
            const SizedBox(width: 12),
          ],
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSelectionTileWithTrailing({required String label, required String value, IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: borderGrey, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 22, color: Colors.grey),
            const SizedBox(width: 12),
          ],
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey))),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderGrey, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Switch(
            value: false,
            onChanged: (v) {},
            activeColor: primaryPink,
          ),
        ],
      ),
    );
  }

  // --- Reusable Logic from previous steps ---

  Widget _buildPromptsSection() {
    return Column(
      children: [
        _buildSectionHeader('Prompts'),
        _buildPromptItem('My dream job is...', 'Designer'),
        const SizedBox(height: 12),
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderGrey, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Select Prompt', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text('Answer prompt', style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            Positioned(bottom: -15, child: CircleAvatar(backgroundColor: primaryPink, radius: 15, child: const Icon(Icons.add, color: Colors.white, size: 18))),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPromptItem(String title, String answer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: borderGrey, width: 1.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(answer, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMediaSection() {
    return Column(
      children: [
        Row(
          children: [
            _buildDot(),
            const SizedBox(width: 8),
            const Text('Media', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 20),
          itemBuilder: (context, index) => _buildPhotoCell(index),
        ),
      ],
    );
  }

  Widget _buildPhotoCell(int index) {
    final bool isFilled = _photos[index] != null;
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: lightGrey, borderRadius: BorderRadius.circular(14)),
          child: isFilled ? Image.file(File(_photos[index]!), fit: BoxFit.cover, width: double.infinity, height: double.infinity) : const SizedBox.expand(),
        ),
        Positioned(
          bottom: -10,
          child: GestureDetector(
            onTap: () => _onPhotoTap(index),
            child: CircleAvatar(
              backgroundColor: primaryPink,
              radius: 14,
              child: Icon(isFilled ? Icons.edit : Icons.add, color: Colors.white, size: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMeSection() {
    return Column(
      children: [
        _buildSectionHeader('About me', important: true),
        TextField(
          controller: _aboutMeController,
          maxLength: 300,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter your short information.',
            counterText: '$_charCount/300',
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: borderGrey)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryPink)),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: lightGrey, borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.arrow_back_ios, size: 12), Text('Edit Profile')]),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(controller: _tabController, labelColor: primaryPink, unselectedLabelColor: Colors.grey, indicatorColor: primaryPink, tabs: const [Tab(text: 'Edit Profile'), Tab(text: 'Preview')]);
  }

  Widget _buildDot() => Container(width: 8, height: 8, decoration: const BoxDecoration(color: primaryPink, shape: BoxShape.circle));
}