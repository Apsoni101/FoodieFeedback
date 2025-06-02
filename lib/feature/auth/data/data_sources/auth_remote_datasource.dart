import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_auth%20_service.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_firestore_service.dart';
import 'package:foodiefeedback/feature/auth/data/models/user_model.dart';

/// abstract auth data source calling firebaseAuth service
abstract class AuthRemoteDataSource {
  ///used for signIn with email and password
  Future<Either<Failure, UserModel>> signUpWithEmail(
    final String name,
    final String email,
    final String password,
  );

  ///used for signIn with email and password
  Future<Either<Failure, UserModel>> signInWithEmail(
    final String email,
    final String password,
  );

  ///used for signingOut User
  Future<Either<Failure, Unit>> signOut();

  ///used for signIn with Google
  Future<Either<Failure, UserModel>> signInWithGoogle();

  ///used for checking signIn
  bool isSignedIn();


}

/// auth data source implementation for calling firebaseAuth service
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ///creates an instance of auth datasource impl
  AuthRemoteDataSourceImpl({
    required this.authService,
    required this.firestoreService,
  });

  ///calls auth service
  final FirebaseAuthService authService;
  final FirebaseFirestoreService firestoreService;

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(
    final String email,
    final String password,
  ) async {
    final Either<Failure, User> result = await authService.signInWithEmail(
      email,
      password,
    );
    return result.fold(Left.new, (final User user) async{
      final Either<Failure, Map<String, dynamic>> userData =
          await firestoreService.getDocument(
        collectionPath: 'users',
        docId: user.uid,
      );

      return userData.fold(
            (final Failure failure) {// do by parsing
          final UserModel fallbackUser = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
          );
          return Right(fallbackUser);
        },
            (final Map<String, dynamic> data) {
          final UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: data['name'] ?? '',
          );
          return Right(userModel);
        },
      );


    });
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    final Either<Failure, User> result = await authService.signInWithGoogle();
    return result.fold(Left.new, (final User user) async {
      final Either<Failure, Map<String, dynamic>> userData =
          await firestoreService.getDocument(
            collectionPath: 'users',
            docId: user.uid,
          );

      return userData.fold(
        (final Failure failure) {
          final UserModel fallbackUser = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? '',
          );
          return Right(fallbackUser);
        },
        (final Map<String, dynamic> data) {
          final UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            name: data['name'] ?? '',
          );
          return Right(userModel);
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() => authService.signOut();

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail(
    final String email,
    final String name,
    final String password,
  ) async {
    final Either<Failure, User> result = await authService.signUpWithEmail(
      email,
      password,
    );
    return result.fold(Left.new, (final User user) async {
      try {
        await firestoreService.setData(
          collectionPath: 'users',
          docId: user.uid,
          data: UserModel(uid: user.uid, email: email, name: name).toJson(),
        );
        return Right<Failure, UserModel>(UserModel.fromFirebaseUser(user));
      } catch (e) {
        return Left<Failure, UserModel>(Failure("User mapping failed: $e"));
      }
    });
  }

  @override
  bool isSignedIn() => authService.auth.currentUser != null;

}
