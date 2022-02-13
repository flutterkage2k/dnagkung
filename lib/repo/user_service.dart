import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnagkung/utils/logger.dart';

class UserService {
  Future firestoreTest() async {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .add({'testing': 'testing value', 'number': 1211222});
  }

  void firestoreReadTest() {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .doc('PtJVa3GyIy5nncLTx0AY')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) =>
            logger.d(value.data()));
  }
}
