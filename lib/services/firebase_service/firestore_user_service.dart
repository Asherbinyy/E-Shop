import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/modules/auth/models/user_model.dart';


class FireStoreUserService {
  final _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
   try {
     return await _userCollection.doc(userModel.firebaseId).set(userModel.toJson());
   } catch (error) {
     return Future.error('something went wrong => ${error.toString()}');
   }
  }
  // void getUser (UserModel userModel,{String ? userId}) async {
  //   final _ref= await _userCollection.doc(userId).get();
  //   UserModel.fromJson(_ref.data()!);
  // }
}

class FireStoreUserDataService {
  final _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<UserModel?>  getUser({String ? userID}) async {
    try {
       await _userCollection.doc(userID).get().then((value) {
         return UserModel.formJson(value.data()!);
       });
    } catch (error) {
      return await Future.error('something went wrong => ${error.toString()}');
    }
  }

}
