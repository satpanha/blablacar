import '../../../model/ride/locations.dart';
import '../../../services/locations_service.dart';
import '../../theme/theme.dart';
import 'package:flutter/material.dart';

Future<Location?> showLocationPicker(
  BuildContext context, {
  Location? initial,
}) {
  return showModalBottomSheet<Location>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (c) => _LocationPickerContent(initial: initial),
  );
}

class _LocationPickerContent extends StatefulWidget {
  final Location? initial;
  const _LocationPickerContent({this.initial});

  @override
  State<_LocationPickerContent> createState() => _LocationPickerContentState();
}

class _LocationPickerContentState extends State<_LocationPickerContent> {
  String query = '';
  static final List<Location> _recent = [];

  // List<Location> get _all => LocationsService.availableLocations;
  // => query.isEmpty
  // ? _all
  // : _all
  //       .where(
  //         (loc) => loc.name.toLowerCase().contains(query.toLowerCase()),
  //       )
  //       .toList();
  List<Location> get filterd {
    if (query.isEmpty) return LocationsService.availableLocations;
    return LocationsService.availableLocations
        .where(
          (location) =>
              location.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void _select(Location loc) {
    _recent.remove(loc);
    _recent.insert(0, loc);
    if (_recent.length > 5) _recent.removeLast();
    Navigator.of(context).pop(loc);
  }

  void onBackTap() {
    Navigator.pop<Location>(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.initial != null) query = widget.initial!.name;
  }

  void onSearchChange(String search) {
    setState(() {
      query = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationSearchBar(
              onBackTap: onBackTap,
              onSearchChanged: onSearchChange,
              initSearch: query,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: filterd.length,

                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: BlaColors.greyLight,
                  indent: 56,
                  endIndent: 16,
                ),

                itemBuilder: (context, index) => LocationTile(
                  location: filterd[index],
                  onTap: _select,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({
    super.key,
    required this.onBackTap,
    required this.onSearchChanged,
    required this.initSearch,
  });

  final String initSearch;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onClearTap() {
    _searchController.clear();
    widget.onSearchChanged(""); 
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlaColors.greyLight,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: const InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),

          searchIsNotEmpty
              ? IconButton(
                  onPressed: onClearTap,
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, required this.onTap});

  final Location location;
  final ValueChanged<Location> onTap;

  String get title => location.name;
  String get subTitle => location.country.name;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(location),

      leading: Icon(Icons.location_on_outlined, color: BlaColors.iconLight),

      title: Text(title, style: BlaTextStyles.body),

      subtitle: Text(
        subTitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
