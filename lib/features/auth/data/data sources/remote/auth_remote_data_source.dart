import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore store;

  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;

  final Connectivity connectivity;
  const AuthRemoteDataSource(
    this.auth,
    this.store,
    this.googleSignIn,
    this.facebookAuth,
    this.connectivity,
  );
  @override
  Future<UserModel> login(LoginParams params) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

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
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final LoginResult loginResult = await facebookAuth.login();

    final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final UserCredential credential =
        await auth.signInWithCredential(facebookCredential);

    final UserModel user = UserModel(
      name: auth.currentUser!.displayName!,
      email: auth.currentUser!.email!,
      phone: auth.currentUser!.phoneNumber!,
      imgUrl: auth.currentUser!.photoURL!,
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
      name: auth.currentUser!.displayName!,
      email: auth.currentUser!.email!,
      phone: auth.currentUser!.phoneNumber!,
      imgUrl: auth.currentUser!.photoURL!,
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
}
