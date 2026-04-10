import 'package:flutter/material.dart';
import 'data/repositories/location/location_repository_mock.dart';
import 'data/repositories/ride/ride_repository_mock.dart';
import 'data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'main_common.dart';

void main() {
  final locationRepository = LocationRepositoryMock();
  final rideRepository = RideRepositoryMock();
  final ridePreferenceRepository = RidePreferenceRepositoryMock();

  runApp(
    BlaBlaApp(
      locationRepository: locationRepository,
      rideRepository: rideRepository,
      ridePreferenceRepository: ridePreferenceRepository,
    ),
  );
}
