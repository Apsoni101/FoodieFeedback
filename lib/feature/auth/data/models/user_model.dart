import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';

///responsible for converting firebase user to UserEntity
class UserModel extends UserEntity {
  ///creates an instance of userModel
  const UserModel({required super.uid, required super.email, required super.name});

  ///responsible for converting firebase user to UserEntity
  factory UserModel.fromFirebaseUser(final User user) => UserModel(
    uid: user.uid,
    email: user.email ?? '',
    name: user.displayName ?? '',
  );
  Map<String, dynamic> toJson() => <String,dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
    };
}
