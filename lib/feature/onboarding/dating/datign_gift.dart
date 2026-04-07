import 'package:flutter/material.dart';

class DatingGift extends StatefulWidget {
  const DatingGift({super.key});

  @override
  State<DatingGift> createState() => _DatingGiftState();
}

class _DatingGiftState extends State<DatingGift> {
  // 1. Logic State Variables
  String selectedCategory = "All";
  int? selectedGiftId;

  final List<String> categories = ["All", "Romantic", "Cute", "Premium", "Trending"];

  // 2. Mock Data with categories
  final List<Map<String, dynamic>> allGifts = [
    {"id": 1, "name": "Ethereal Diamond", "price": "2,400", "cat": "Romantic"},
    {"id": 2, "name": "Golden Rose", "price": "1,200", "cat": "Romantic"},
    {"id": 3, "name": "Cute Panda", "price": "800", "cat": "Cute"},
    {"id": 4, "name": "Premium Watch", "price": "5,000", "cat": "Premium"},
    {"id": 5, "name": "Crystal Heart", "price": "1,500", "cat": "Trending"},
    {"id": 6, "name": "Silk Scarf", "price": "900", "cat": "Premium"},
    {"id": 7, "name": "Chocolate Box", "price": "400", "cat": "Cute"},
    {"id": 8, "name": "Gold Necklace", "price": "3,200", "cat": "Romantic"},
    {"id": 9, "name": "Silver Ring", "price": "2,100", "cat": "Trending"},
  ];

  @override
  Widget build(BuildContext context) {
    // 3. Filter Logic
    final filteredGifts = selectedCategory == "All"
        ? allGifts
        : allGifts.where((g) => g['cat'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20)),
        title: const Text(
          'Gift Store',
          style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                const Text("2040", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Icon(Icons.account_balance_wallet_outlined, color: Colors.grey[600], size: 18),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4213/4213958.png',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Express with Precious Gifts",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Add a little surprise to your connections",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 25),
            
                  // 4. Category Filter List
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: categories.map((cat) => _buildCategoryChip(cat)).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
            
                  // 5. Grid of Filtered Gifts
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: filteredGifts.length,
                      itemBuilder: (context, index) {
                        final gift = filteredGifts[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGiftId = gift['id'];
                            });
                          },
                          child: _buildGiftCard(
                              gift['name'],
                              gift['price'],
                              selectedGiftId == gift['id']
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: selectedGiftId == null ? null : () {
              print("Proceeding with gift ID: $selectedGiftId");
            },
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selectedGiftId == null ? Colors.grey : const Color(0xFFAC4373),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),

        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
          selectedGiftId = null; // Reset selection when category changes
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFAC4373) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFAC4373) : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGiftCard(String title, String price, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? const Color(0xFFAC4373) : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=200&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isSelected)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xFF7B39FD),
                      child: Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.monetization_on, color: Colors.orange, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? const Color(0xFFAC4373) : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}