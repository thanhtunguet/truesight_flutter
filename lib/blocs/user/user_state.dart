part of 'user_bloc.dart';

@immutable
sealed class UserState<T extends TruesightAppUser> extends Equatable {
  bool get isLoading => this is UserAuthenticationPendingState<T>;

  bool get isAuthenticated => this is UserAuthenticatedState<T>;

  UserAuthenticatedState<T> get authenticated =>
      this as UserAuthenticatedState<T>;
}

final class UserInitial<T extends TruesightAppUser> extends UserState<T> {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserAuthenticatedState<T extends TruesightAppUser>
    extends UserState<T> {
  final T user;

  UserAuthenticatedState(this.user);

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        user,
        user.id.value,
      ];
}

final class UserAuthenticationErrorState<T extends TruesightAppUser>
    extends UserState<T> {
  final Object error;

  UserAuthenticationErrorState(this.error);

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        error,
      ];
}

final class UserAuthenticationPendingState<T extends TruesightAppUser>
    extends UserState<T> {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserLocalAuthRejectedState<T extends TruesightAppUser>
    extends UserState<T> {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserLocalAuthEmptyErrorState<T extends TruesightAppUser>
    extends UserState<T> {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserTenantSelectionState<T extends TruesightAppUser>
    extends UserState<T> {
  final List<Tenant> tenants;

  UserTenantSelectionState(this.tenants) : super();

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        ...tenants,
      ];
}
