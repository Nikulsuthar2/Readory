import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  final SharedPreferences _prefs;
  static const String _userKey = 'local_user_session';

  LocalAuthRepository(this._prefs);

  @override
  Stream<UserEntity?> get authStateChanges {
    // For local auth, we can just emit the current user. 
    // If we wanted to be reactive to changes from other places, we'd need a StreamController.
    // For now, simple approach: check prefs immediately.
    return Stream.value(currentUser);
  }

  @override
  UserEntity? get currentUser {
    // Always return a default offline user to bypass login requirements
    return const UserEntity(id: 'offline_user', email: 'offline@readory.app');
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Always succeed for local offline mode
      await _prefs.setBool(_userKey, true);
      return Right(currentUser!);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Always succeed for local offline mode
      await _prefs.setBool(_userKey, true);
      return Right(currentUser!);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _prefs.setBool(_userKey, false);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
