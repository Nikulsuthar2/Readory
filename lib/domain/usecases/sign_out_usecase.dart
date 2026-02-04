import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return _authRepository.signOut();
  }
}
