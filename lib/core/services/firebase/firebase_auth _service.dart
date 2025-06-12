import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

///firebase service similar to network service
class FirebaseAuthService {
  FirebaseAuthService({final FirebaseAuth? auth})
      : auth = auth ?? FirebaseAuth.instance;
  ///firebase auth instance
  final FirebaseAuth auth;
  ///used for signIn with email and password
  Future<Either<Failure, User>> signUpWithEmail(
    final String email,
    final String password,
  ) async {
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right<Failure, User>(result.user!);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, User>(
        Failure(e.message ?? "SignUp failed", errorCode: e.code),
      );
    }on FirebaseException catch (e) {
      return Left<Failure, User>(
        Failure('Firebase error: ${e.message}', errorCode: e.code),
      );
    } catch (e) {
      return Left<Failure, User>(Failure('Unexpected error: $e'));
    }
  }

  ///used for signIn with email and password
  Future<Either<Failure, User>> signInWithEmail(
    final String email,
    final String password,
  ) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right<Failure, User>(result.user!);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, User>(
        Failure(e.message ?? "Login failed", errorCode: e.code),
      );
    }on FirebaseException catch (e) {
      return Left<Failure, User>(
        Failure('Firebase error: ${e.message}', errorCode: e.code),
      );
    } catch (e) {
      return Left<Failure, User>(Failure('Unexpected error: $e'));
    }
  }

  ///used for signingOut User
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await auth.signOut();
      return const Right<Failure, Unit>(unit);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, Unit>(
        Failure("Something went wrong $e", errorCode: e.code),
      );
    } on FirebaseException catch (e) {
      return Left<Failure, Unit>(
        Failure('Firebase error: ${e.message}', errorCode: e.code),
      );
    } catch (e) {
      return Left<Failure, Unit>(Failure('Unexpected error: $e'));
    }
  }

  ///used for signIn with Google
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential result = await auth.signInWithCredential(credential);
      return Right<Failure, User>(result.user!);
    } on FirebaseAuthException catch (e) {
      return Left<Failure, User>(Failure(e.message ?? "Login failed"));
    } on FirebaseException catch (e) {
      return Left<Failure, User>(
        Failure('Firebase error: ${e.message}', errorCode: e.code),
      );
    } catch (e) {
      return Left<Failure, User>(Failure('Unexpected error: $e'));
    }
  }
}
