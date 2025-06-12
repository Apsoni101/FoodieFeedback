import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';

/// Firebase Storage service similar to other Firebase services
class FirebaseStorageService {
  FirebaseStorageService({final FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  /// Uploads a file to Firebase Storage
  Future<Either<Failure, String>> uploadFile({
    required final String path,
    required final File file,
    final String? contentType,
  }) async {
    try {
      final Reference ref = _storage.ref().child(path);
      final UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: contentType),
      );

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return Right<Failure, String>(downloadUrl);
    } on FirebaseException catch (e) {
      return Left<Failure, String>(
        Failure('Failed to upload file: ${e.message}',errorCode: e.code),
      );
    } catch (e) {
      return Left<Failure, String>(
        Failure('Unexpected error during file upload: $e',),
      );
    }
  }





}