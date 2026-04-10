import 'package:flutter/material.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

class BlaBlaApp extends StatelessWidget {
  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceRepository ridePreferenceRepository;

  const BlaBlaApp({
    super.key,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(
        body: HomeScreen(
          locationRepository: locationRepository,
          rideRepository: rideRepository,
          ridePreferenceRepository: ridePreferenceRepository,
        ),
      ),
    );
  }
}
