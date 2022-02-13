
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reade/models/user_model.dart';


class AllUserService {
  final CollectionReference _allUserReference =
  FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> fetchAllUser() async {
    try {
      QuerySnapshot result = await _allUserReference.get();
      List<UserModel> allUsers = result.docs.map(
            (e) {
          return UserModel.fromJson(
              e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return allUsers;
    } catch (e) {
      rethrow;
    }
  }
}
