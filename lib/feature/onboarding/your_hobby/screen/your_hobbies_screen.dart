import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/interest_hobby_bloc.dart';
import '../bloc/interest_hobby_event.dart';
import '../bloc/interest_hobby_state.dart';
import '../repository/interest_hobby_repository.dart';
import '../widget/interest_hobby_shimmer.dart';

class YourHobbiesScreen extends StatefulWidget {
  const YourHobbiesScreen({super.key});

  @override
  State<YourHobbiesScreen> createState() => _YourHobbiesScreenState();
}

class _YourHobbiesScreenState extends State<YourHobbiesScreen> {
  final Set<String> _selected = {};
  final int _maxSelection = 5;
  final int _minSelection = 3;

  void _toggleSelection(String value) {
    setState(() {
      if (_selected.contains(value)) {
        _selected.remove(value);
      } else {
        if (_selected.length < _maxSelection) {
          _selected.add(value);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InterestHobbyBloc(InterestHobbyRepository())
        ..add(FetchInterestHobbyEvent()),
      child:  BlocBuilder<InterestHobbyBloc, InterestHobbyState>(
          builder: (context, state) {
            if (state is InterestHobbyLoading) {
              return  InterestHobbyShimmer();
            }
            if (state is InterestHobbyLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      "Interests & Hobbies",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtitle
                    Text(state.model.data.first.title,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.model.data.first.options.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final option = state.model.data.first.options[index];
                        final isSelected = _selected.contains(option.value);

                        return GestureDetector(
                          onTap: () => _toggleSelection(option.value),

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.pink.shade300
                                    : Colors.grey.shade200,
                                width: isSelected ? 1 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 32,
                                  color: isSelected
                                      ? Colors.pink.shade400
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  option.label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? Colors.pink.shade400
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Selection counter
                    Center(
                      child: Text(
                        "${_selected.length} / $_maxSelection selected",
                        style: TextStyle(
                          fontSize: 13,
                          color: _selected.length >= _minSelection
                              ? Colors.green.shade600
                              : Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            if (state is InterestHobbyError) {
              return Text(state.message);
            }
            return const SizedBox();
        }
      ),
    );
  }
}