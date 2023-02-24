// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserData {
//   String role = '';
//   String fullname = '';
//   String alamat = '';
//   int nik = 0;
//   String email = '';
//   int telp = 0;
//   String uid = '';
//   bool isDataComplete = false;

//   Future get(String? uid) async {
//     Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot = await FirebaseFirestore.instance
//         .collection('laporan')
//         .doc(uid)
//         .snapshots();
//     //     .then((document) {
//     //   if (document.exists) {
//     //     role = document.data()!['role'];
//     //     fullname = document.data()!['fullname'];
//     //     email = document.data()!['email'];
//     //     uid = document.data()!['uid'];
//     //     isDataComplete = document.data()!['is_data_complete'];
//     //   } else {
//     //     print('user tidak ditemukan');
//     //   }
//     // })
//     if (snapshot.) {
      
//     }
//     return snapshot;
//   }
// }
