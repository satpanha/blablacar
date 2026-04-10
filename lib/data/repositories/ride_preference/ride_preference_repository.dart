import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  List<RidePreference> getRidePreferences();
  void saveRidePreference(RidePreference pref);
}
