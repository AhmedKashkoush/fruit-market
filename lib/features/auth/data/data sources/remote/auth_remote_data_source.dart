import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_market/core/constants/firebase_paths.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> login(LoginParams params);
  Future<UserModel> signup(SignUpParams params);

  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<void> logout();

  Future<void> sendPasswordResetEmail(String email);
  Future<void> sendOTP(String phone);
  Future<void> verifyOTP(String otp);
  Future<void> updatePassword(LoginParams params);

  Future<void> uploadPhoto(File photo);
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore store;
  final FirebaseStorage storage;

  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;

  final Connectivity connectivity;
  const AuthRemoteDataSource(
    this.auth,
    this.store,
    this.storage,
    this.googleSignIn,
    this.facebookAuth,
    this.connectivity,
  );

  ///Login
  @override
  Future<UserModel> login(LoginParams params) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    try {
      final UserCredential credentials = await auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      final Map<String, dynamic>? data = (await store
              .collection(FirebasePaths.users)
              .doc(credentials.user?.uid)
              .get())
          .data();
      if (data == null) {
        throw const AuthException('User with this credentials not found');
      }

      return UserModel.fromJson(data);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code);
    }
  }

  ///Logout
  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  ///Facebook Login
  @override
  Future<UserModel> signInWithFacebook() async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final LoginResult loginResult = await facebookAuth.login();
    final LoginStatus status = loginResult.status;
    debugPrint(
        '=====================================Message: ${loginResult.message}');
    switch (status) {
      case LoginStatus.success:
        break;
      case LoginStatus.cancelled:
        throw const AuthException(
            'Facebook authentication process was cancelled');
      case LoginStatus.failed:
        throw const AuthException('Facebook authentication process failed');
      case LoginStatus.operationInProgress:
        break;
    }

    final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final UserCredential credential =
        await auth.signInWithCredential(facebookCredential);

    debugPrint('=====================================User: ${credential.user}');

    final UserModel user = UserModel(
      name: credential.user!.displayName!,
      email: credential.user!.email!,
      phone: credential.user!.phoneNumber ?? '',
      imgUrl: credential.user!.photoURL!,
      gender: '',
      address: '',
    );

    final Map<String, dynamic>? userData = (await store
            .collection(FirebasePaths.users)
            .doc(credential.user?.uid)
            .get())
        .data();
    if (userData != null) {
      await store
          .collection(FirebasePaths.users)
          .doc(credential.user?.uid)
          .update(user.toJson());
      return user;
    }

    await store
        .collection(FirebasePaths.users)
        .doc(credential.user?.uid)
        .set(user.toJson());
    return user;
  }

  ///Google Login
  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleAccount?.authentication;

    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential credential =
        await auth.signInWithCredential(googleCredential);
    final UserModel user = UserModel(
      name: credential.user!.displayName!,
      email: credential.user!.email!,
      phone: credential.user!.phoneNumber ?? '',
      imgUrl: credential.user!.photoURL!,
      gender: '',
      address: '',
    );

    final Map<String, dynamic>? userData = (await store
            .collection(FirebasePaths.users)
            .doc(credential.user?.uid)
            .get())
        .data();
    if (userData != null) {
      await store
          .collection(FirebasePaths.users)
          .doc(credential.user?.uid)
          .update(user.toJson());
      return user;
    }

    await store
        .collection(FirebasePaths.users)
        .doc(credential.user?.uid)
        .set(user.toJson());
    return user;
  }

  ///Signup
  @override
  Future<UserModel> signup(SignUpParams params) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> userData =
        (await store
                .collection(FirebasePaths.users)
                .where('email', isEqualTo: params.email)
                .where('phone', isEqualTo: params.phone)
                .get())
            .docs;

    if (userData.isNotEmpty) {
      throw const AuthException('Invalid user credentials');
    }

    final UserCredential credentials =
        await auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    final UserModel user = UserModel(
      name: params.name,
      email: params.email,
      phone: params.phone,
      imgUrl: params.imgUrl,
      gender: params.gender,
      address: params.address,
      birthday: params.birthday,
    );

    await store
        .collection(FirebasePaths.users)
        .doc(credentials.user?.uid)
        .set(user.toJson());
    return user;
  }

  @override
  Future<void> sendOTP(String phone) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    await auth.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Future<void> updatePassword(LoginParams params) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    await auth.currentUser?.updatePassword(params.password);
  }

  @override
  Future<void> uploadPhoto(File photo) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
    final String id = auth.currentUser!.uid;
    final String url = await (await storage
            .ref()
            .child('${FirebasePaths.profilePhotos}/$id/$id')
            .putFile(photo))
        .ref
        .getDownloadURL();
    await store.collection(FirebasePaths.users).doc(id).update({'imgUrl': url});
  }

  @override
  Future<void> verifyOTP(String otp) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }
}
