import '../../../features/auth/domain/entities/user_entity.dart';

class UserState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;
  final bool isUnauthorized;

  UserState({
    this.isLoading = false,
    this.user,
    this.error,
    this.isUnauthorized = false,
  });

  UserState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? error,
    bool? isUnauthorized,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      isUnauthorized: isUnauthorized ?? false,
    );
  }
}
