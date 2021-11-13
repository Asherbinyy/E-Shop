//
//
// ///USER ID
//
// class UserToken {
//   final GetStorage _box = GetStorage();
//   /// initial uId value
//   String? _initialUID = '';
//   /// loads Uid from cached memory (if failed returns initial uId)
//   String? get uId => _box.read(UID) ?? _initialUID;
//
//   // String? get uId => _uId;
//
//   void saveUId(String uIdValue) async {
//     await _box.write(UID, uIdValue).then((_) => _initialUID = uIdValue).catchError(
//           (error) => print('couldnt save UId=>${error.toString()}'),
//         );
//   }
//
//
//   /// called when signing out method is called
//   Future <void> resetToken () async => await _box.remove(UID);
// }
