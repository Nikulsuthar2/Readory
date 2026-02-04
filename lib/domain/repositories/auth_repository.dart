import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();
  
  UserEntity? get currentUser;
}
