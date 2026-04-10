import 'ride_repository.dart';
import '../../../model/ride/ride.dart';
import '../../dummy_data.dart';

class RideRepositoryMock implements RideRepository {
  @override
  List<Ride> getRides() {
    return fakeRides.toList();
  }
}
