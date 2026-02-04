import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readory/data/repositories/settings_repository_impl.dart'; // accessing sharedPreferencesProvider
import 'package:readory/data/repositories/local_auth_repository.dart';
import 'package:readory/domain/repositories/auth_repository.dart';
import 'package:readory/domain/usecases/sign_in_usecase.dart';
import 'package:readory/domain/usecases/sign_up_usecase.dart';
import 'package:readory/domain/usecases/sign_out_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalAuthRepository(prefs);
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

final authStateChangesProvider = StreamProvider<dynamic>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
