import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:access_control_flutter/models/userData.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get userData => _userData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setUserData(UserData? userData) {
    _userData = userData;
    notifyListeners();
  }

  Future<void> fetchUserDataFromBackend() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }

    try {
      _isLoading = true;
      notifyListeners();

      final userData = await fetchUserData(currentUser.uid);
      setUserData(userData);
      print('Getting user data');
    } catch (error) {
      print('Failed to fetch user data: $error');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<UserData> fetchUserData(String uid) async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        final userData = UserData.fromJson(userSnapshot.data()!);
        return userData;
      } else {
        throw Exception('User document not found');
      }
    } catch (error) {
      print('Failed to fetch user data: $error');
      rethrow;
    }
  }
}
