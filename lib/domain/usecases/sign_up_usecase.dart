import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return _authRepository.signUpWithEmailPassword(email: email, password: password);
  }
}
