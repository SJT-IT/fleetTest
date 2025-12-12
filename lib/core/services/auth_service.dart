import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => firebaseAuth.currentUser;

  // -------------------------
  // SIGN IN
  // -------------------------
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // -------------------------
  // CREATE ACCOUNT + ROLE
  // -------------------------
  Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String role, // driver or dealer
  }) async {
    // Validate role
    if (role != "driver" && role != "dealer") {
      throw Exception("Invalid role. Only 'driver' or 'dealer' allowed.");
    }

    // Create user in Firebase Auth
    UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Create Firestore document with role
    await firestore.collection("users").doc(cred.user!.uid).set({
      "email": email,
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return cred;
  }

  // -------------------------
  // GET USER ROLE
  // -------------------------
  Future<String?> getUserRole() async {
    if (currentUser == null) return null;

    DocumentSnapshot snapshot = await firestore
        .collection("users")
        .doc(currentUser!.uid)
        .get();

    if (!snapshot.exists) return null;

    return snapshot["role"];
  }

  // -------------------------
  // SIGN OUT
  // -------------------------
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // -------------------------
  // RESET PASSWORD
  // -------------------------
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // -------------------------
  // UPDATE DISPLAY NAME
  // -------------------------
  Future<void> updateUsername({required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  // -------------------------
  // DELETE ACCOUNT
  // -------------------------
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);

    // Delete Firestore document
    await firestore.collection("users").doc(currentUser!.uid).delete();

    // Delete Auth account
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  // -------------------------
  // RESET PASSWORD FROM CURRENT
  // -------------------------
  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}
