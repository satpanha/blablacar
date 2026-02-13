import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/locations_service.dart';
import 'package:blabla/ui/theme/theme.dart';
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

  List<Location> get _all => LocationsService.availableLocations;
  List<Location> get _filterd => query.isEmpty
      ? _all
      : _all
            .where(
              (loc) => loc.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

  void _select(Location loc) {
    _recent.remove(loc);
    _recent.insert(0, loc);
    if (_recent.length > 5) _recent.removeLast();
    Navigator.of(context).pop(loc);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Select Location",
                style: BlaTextStyles.heading.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: BlaColors.neutralDark,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search location...",
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: BlaColors.neutralDark,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: BlaColors.greyLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: BlaColors.neutralDark,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: ListView.separated(
                itemCount: _filterd.length,
                separatorBuilder: (_, c) => Divider(
                  height: 1,
                  color: BlaColors.greyLight,
                  indent: 56, // indent after the icon space
                  endIndent: 16,
                ),
                itemBuilder: (context, index) {
                  final loc = _filterd[index];

                  return ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: BlaColors.neutralDark,
                      size: 24,
                    ),
                    title: Text(
                      loc.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: BlaColors.neutralDark,
                      ),
                    ),
                    subtitle: Text(
                      loc
                          .country
                          .name, 
                      style: TextStyle(
                        fontSize: 14,
                        color: BlaColors.neutralLight,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: BlaColors.neutralDark,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: () => _select(loc),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
