// import 'package:cloud_firestore/cloud_firestore.dart';
//
// abstract class FireStoreHomeService {
//   querySnapShots();
// }
//
// class FireStoreCategoryService implements FireStoreHomeService {
//   final _categoryCollection =
//       FirebaseFirestore.instance.collection('Categories');
//
//   @override
//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
//       querySnapShots() async {
//     final orderedCollection =
//         _categoryCollection.orderBy("index", descending: false);
//     final value = await orderedCollection.get();
//     try {
//       return value.docs;
//     } catch (error) {
//       return Future.error('Error in Getting categorySnaps=>$error');
//     }
//   }
// }
//
// class FireStoreProductService implements FireStoreHomeService {
//   final _productCollection = FirebaseFirestore.instance.collection('Products');
//
//   @override
//   Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
//       querySnapShots() async {
//     final orderedCollection =
//         _productCollection.orderBy("index", descending: false);
//     final value = await orderedCollection.get();
//     try {
//       return value.docs;
//     } catch (error) {
//       return Future.error('Error in Getting Products Snaps=>$error');
//     }
//   }
// }
