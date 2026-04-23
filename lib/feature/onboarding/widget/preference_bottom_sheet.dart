import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:staybea_app/core/utils/app_size.dart';

const _pink = Color(0xFFAD3B6E);

class PreferenceBottomSheet extends StatefulWidget {
  final String title;
  final List<String> selectedItems;
  final List<String> allItems;
  final bool showSearch;
  final bool showOpenToAll;
  final int? maxSelection;
  final String topic;
  final String icon;

  final bool isWrap;

  const PreferenceBottomSheet({
    super.key,
    required this.title,
    required this.selectedItems,
    required this.allItems,
    required this.topic,
    required this.icon,
    this.showSearch = true,
    this.showOpenToAll = false,
    this.maxSelection,
    this.isWrap = true, // Default hum wrap hi rakh rahe hain
  });

  @override
  State<PreferenceBottomSheet> createState() => _PreferenceBottomSheetState();
}

class _PreferenceBottomSheetState extends State<PreferenceBottomSheet> {
  late List<String> selected;
  bool openToAll = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selected = [...widget.selectedItems];
  }

  // Toggle selection logic for clean code
  void toggleItem(String item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        if (widget.maxSelection == null || selected.length < widget.maxSelection!) {
          selected.add(item);
          openToAll = false; // Item select hote hi 'Open to all' off ho jaye
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Container(
      // height: MediaQuery.of(context).size.height * .82,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Header
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // Light shadow
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4), // Neeche ki taraf shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: appSize.mediumText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "${selected.length}/${widget.maxSelection ?? widget.allItems.length}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          /// Top Selected Chips (Always Wrap)
          if (selected.isNotEmpty)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // Light shadow
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4), // Neeche ki taraf shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selected.map((e) => _buildChip(e)).toList(),
              ),
            ),

          if (widget.showSearch)
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

          if(openToAll)
          CheckboxListTile(
            value: openToAll,
            activeColor: _pink,
            title: const Text("Open to all"),
            contentPadding: EdgeInsets.zero,
            onChanged: (v) {
              setState(() {
                openToAll = v ?? false;
                if (openToAll) selected.clear();
              });
            },
          ),
          if(widget.showOpenToAll)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {

                  },),
                  Text("Open To All")
                ],
              ),
            ),
          /// Options Area (Dynamic Layout)
          Flexible(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF3EDF7), Colors.white],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(widget.topic !='')
                  Row(
                    children: [
                      Text(widget.icon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Text(widget.topic, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Flexible(
                    child: SingleChildScrollView(
                      child: widget.isWrap
                          ? _buildWrapLayout()
                          : _buildColumnLayout(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _pink,
                      side: const BorderSide(color: _pink),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Close"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, selected),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pink,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Apply", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
        ],
      ),
    );
  }

  /// Layout 1: Horizontal Wrap (Chips Style)
  Widget _buildWrapLayout() {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: widget.allItems.map((item) {
        final isSelected = selected.contains(item);
        return GestureDetector(
          onTap: () => toggleItem(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: isSelected ? _pink : Colors.grey.shade300),
              color: isSelected ? _pink.withOpacity(.06) : Colors.white,
            ),
            child: Text(
              item,
              style: TextStyle(
                color: isSelected ? _pink : Colors.black87,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Layout 2: Vertical Column (Checkbox Style)
  Widget _buildColumnLayout() {
    return Column(
      children: widget.allItems.map((item) {
        final isSelected = selected.contains(item);
        return CheckboxListTile(
          title: Text(item, style: const TextStyle(fontSize: 14)),
          value: isSelected,
          activeColor: _pink,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onChanged: (_) => toggleItem(item),
        );
      }).toList(),
    );
  }

  /// Helper for top selected chips
  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F1F4),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE7E1E5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF4A4A4A))),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => setState(() => selected.remove(text)),
            child: const Icon(Icons.close, size: 14, color: Color(0xFF6B6B6B)),
          ),
        ],
      ),
    );
  }
}