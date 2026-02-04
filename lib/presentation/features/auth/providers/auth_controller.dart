import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../domain/entities/user_entity.dart';
import 'auth_dependencies_provider.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // Initial state is idle (void)
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await ref.read(signInUseCaseProvider).call(
      email: email,
      password: password,
    );
    
    // Check if disposed?
    // Riverpod doesn't easily expose 'mounted' here, but we can try/catch
    try {
      if (state.hasError) return; // Maybe?
      
      result.fold(
        (failure) => state = AsyncError(failure.message, StackTrace.current),
        (user) => state = const AsyncData(null),
      );
    } catch (e) {
      // Ignore provider disposed errors
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await ref.read(signUpUseCaseProvider).call(
      email: email,
      password: password,
    );

    try {
      result.fold(
        (failure) => state = AsyncError(failure.message, StackTrace.current),
        (user) => state = const AsyncData(null),
      );
    } catch (e) {
      // Ignore
    }
  }
  
  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
        final result = await ref.read(signOutUseCaseProvider).call();
        result.fold(
          (failure) => state = AsyncError(failure.message, StackTrace.current),
          (success) => state = const AsyncData(null), // This might throw if immediately disposed by nav
        );
    } catch (e) {
        // Ignore "Bad state: Future already completed" typically caused by auto-dispose
    }
  }
}
