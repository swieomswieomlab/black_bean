import 'package:test/test.dart';

import '../lib/service/firebase_service.dart';

void main() {
  test('LoadProblemTest', () {
    FirebaseService firebaseService = FirebaseService();
    firebaseService.loadOneProblemFromDatabase('High', 'Math', '2022-1', 1);
  });
}
