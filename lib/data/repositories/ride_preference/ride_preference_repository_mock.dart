import 'ride_preference_repository.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../dummy_data.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  late List<RidePreference> _prefs;

  RidePreferenceRepositoryMock() {
    _prefs = fakeRidePrefs.toList();
  }

  @override
  List<RidePreference> getRidePreferences() {
    return _prefs.toList();
  }

  @override
  void saveRidePreference(RidePreference pref) {
    _prefs.add(pref);
  }
}
