import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

import '../bloc/religion/religion_bloc.dart';
import '../bloc/religion/religion_event.dart';
import '../bloc/religion/religion_state.dart';
import '../model/religion_model.dart';
import '../repository/religion_repository.dart';
import '../widget/religion_shimmer.dart';

class YourReligionScreen extends StatelessWidget {
  const YourReligionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReligionBloc(ReligionRepository())
        ..add(FetchReligionEvent()),
      child: const _ReligionView(),
    );
  }
}

class _ReligionView extends StatefulWidget {
  const _ReligionView();

  @override
  State<_ReligionView> createState() => _ReligionViewState();
}

class _ReligionViewState extends State<_ReligionView> {
  String? _selectedReligion;
  String? _selectedCommunity;
  bool _showReligion = false;
  bool _showCommunity = false;

  List<String> _getCommunitiesFor(String religion, List<Religion> religions) {
    return religions
        .firstWhere(
          (r) => r.name == religion,
      orElse: () => Religion(name: '', communities: []),
    )
        .communities;
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return BlocBuilder<ReligionBloc, ReligionState>(
      builder: (context, state) {

        // ── Loading ──────────────────────────────────────────────
        if (state is ReligionLoading) {
          return ReligionShimmer();
        }

        // ── Error ────────────────────────────────────────────────
        if (state is ReligionError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}',
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: () => context.read<ReligionBloc>().add(FetchReligionEvent()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ── Loaded ───────────────────────────────────────────────
        if (state is ReligionLoaded) {
          final religionData = state.response.data.first;
          final religions = religionData.religions;

          // Religion names list from API
          final religionNames = religions.map((r) => r.name).toList();

          // Communities from API for selected religion
          final communities = _selectedReligion != null
              ? _getCommunitiesFor(_selectedReligion!, religions)
              : <String>[];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: appSize.height * 0.02),

                Text(
                  religionData.title, // ← Title from API
                  style: TextStyle(
                    fontSize: appSize.largeText,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: appSize.height * 0.02),

                AppExpandableField(
                  label: "Religion",
                  hint: "Select Religion",
                  value: _selectedReligion,
                  isOpen: _showReligion,
                  onTap: () {
                    setState(() {
                      _showReligion = !_showReligion;
                      _showCommunity = false;
                    });
                  },
                  items: religionNames,
                  onSelect: (val) {
                    setState(() {
                      _selectedReligion = val;
                      _selectedCommunity = null;
                      _showReligion = false;
                      // _showCommunity = true;
                    });
                  },
                ),

                const SizedBox(height: 20),

                AppExpandableField(
                  label: "Community",
                  hint: "Select Community",
                  value: _selectedCommunity,
                  isOpen: _showCommunity,
                  enabled: _selectedReligion != null,
                  onTap: () {
                    if (_selectedReligion != null) {
                      setState(() {
                        _showCommunity = !_showCommunity;
                        _showReligion = false;
                      });
                    }
                  },
                  items: communities, // ← from API
                  onSelect: (val) {
                    setState(() {
                      _selectedCommunity = val;
                      _showCommunity = false;
                    });
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}