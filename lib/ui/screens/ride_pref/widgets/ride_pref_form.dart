import 'package:blabla/ui/screens/ride_pref/widgets/ride_prefs_input.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/seat_picker_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';

import '../../../widgets/inputs/bla_location_picker.dart';
// import '../../../widgets/actions/bla_button.dart';
import '../../../../utils/date_time_util.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final void Function(RidePref)? onSubmit;

  const RidePrefForm({super.key, this.initRidePref, this.onSubmit});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------.
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparturePressed() async {
    final selected = await showLocationPicker(context, initial: departure);
    if (selected != null) {
      setState(() => departure = selected);
    }
  }

  void onArrivalPressed() async {
    final selected = await showLocationPicker(context, initial: arrival);
    if (selected != null) {
      setState(() => arrival = selected);
    }
  }

  void swapLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  bool get isValid {
    if (departure == null) return false;
    if (arrival == null) return false;
    if (requestedSeats <= 0) return false;
    return true;
  }

  String get formattedDate => DateTimeUtils.formatDateTime(departureDate);

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => departureDate = picked);
    }
  }

  void onSubmit() {
    if (!isValid) return;
    final pref = RidePref(
      departure: departure!,
      departureDate: departureDate,
      arrival: arrival!,
      requestedSeats: requestedSeats,
    );
    widget.onSubmit?.call(pref);
  }

  void onSeatsPressed() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => SeatPickerScreen(initialSeats: requestedSeats),
      ),
    );

    if (result != null) {
      setState(() => requestedSeats = result);
    }
  }
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              // 1 - Input the ride departure
              RidePrefInput(
                isPlaceHolder: showDeparturePLaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? swapLocations : null,
              ),
              const BlaDivider(),

              // 2 - Input the ride arrival
              RidePrefInput(
                isPlaceHolder: showArrivalPLaceHolder,
                title: arrivalLabel,
                leftIcon: Icons.location_on,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              // 3 - Input the ride date
              RidePrefInput(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () => {},
              ),
              const BlaDivider(),

              // 4 - Input the requested number of seats
              RidePrefInput(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () => onSeatsPressed(),
              ),
            ],
          ),
        ),

        // 5 - Launch a search
        BlaButton(
          label: 'Search',
          variant: BlaButtonVariant.primary,
          onPressed: onSubmit,
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: Column(
  //           children: [
  //             // Departure
  //             ListTile(
  //               leading: const Icon(Icons.radio_button_unchecked),
  //               title: Text(departure?.name ?? "Departure"),
  //               trailing: IconButton(
  //                 icon: const Icon(Icons.swap_vert),
  //                 onPressed: swapLocations,
  //               ),
  //               onTap: () async{
  //                 final selected = await showLocationPicker(context, initial: departure);
  //                 if (selected != null) setState(() => departure = selected);
  //               },
  //             ),

  //             const Divider(height: 1),

  //             // Arrival
  //             ListTile(
  //               leading: const Icon(Icons.radio_button_unchecked),
  //               title: Text(arrival?.name ?? "Arrival"),
  //               onTap: () async {
  //                 final selected = await showLocationPicker(
  //                   context,
  //                   initial: arrival,
  //                 );
  //                 if (selected != null) setState(() => arrival = selected);
  //               },
  //             ),

  //             const Divider(height: 1),

  //             // Date
  //             ListTile(
  //               leading: const Icon(Icons.calendar_today),
  //               title: Text(formattedDate),
  //               onTap: pickDate,
  //             ),

  //             const Divider(height: 1),

  //             // Seats
  //             ListTile(
  //               leading: const Icon(Icons.person_outline),
  //               title: const Text("Seats"),
  //               trailing: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   IconButton(
  //                     icon: const Icon(Icons.remove),
  //                     onPressed: requestedSeats > 1
  //                         ? () => setState(() => requestedSeats--)
  //                         : null,
  //                   ),
  //                   Text("$requestedSeats"),
  //                   IconButton(
  //                     icon: const Icon(Icons.add),
  //                     onPressed: () => setState(() => requestedSeats++),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             BlaButton(label: 'Search', variant: BlaButtonVariant.primary, onPressed: onSubmit,)
  //           ],
  //       // const SizedBox(height: 16),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
