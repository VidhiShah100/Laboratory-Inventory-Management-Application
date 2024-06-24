import "dart:typed_data";
import "package:access_control_flutter/Backend%20Tools/imageStorage.dart";
import "package:access_control_flutter/models/userData.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String?> SignUp({
    required String firstname,
    required String lastname,
    required String password,
    required String confirmpassword,
    required String email,
    required Uint8List file,
    // required Bool isAdmin,
  }) async {
    String res = "Some error occured";
    try {
      //to check wheater the password is same as confirm password
      if (password == confirmpassword) {
        //to check if any field is empty.
        if (firstname.isNotEmpty ||
            lastname.isNotEmpty ||
            password.isNotEmpty ||
            email.isNotEmpty) {
          // created the credentials of the user
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          //calling the function which stores image to storage
          String photoUrl =
              await storageMethod().uploadProfileImage('Profile Pics', file);

          //Now to add above cred to db
          UserData user = UserData(
            firstname: firstname,
            email: email,
            uid: cred.user!.uid,
            lastname: lastname,
            Previous: 0,
            Cart: [],
            IssuedItems: [],
            RequestedItems: [],
            PhotoUrl: photoUrl,
          );

          await _firestore
              .collection('users')
              .doc(cred.user!.uid)
              .set(user.toJson());
          res = 'success';
        } else {}
      } else {}
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
