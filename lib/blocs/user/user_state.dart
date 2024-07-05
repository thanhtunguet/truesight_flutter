part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {
  bool get isLoading => this is UserAuthenticationPendingState;

  bool get isAuthenticated => this is UserAuthenticatedState;

  UserAuthenticatedState get authenticated => this as UserAuthenticatedState;
}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserAuthenticatedState extends UserState {
  final TruesightAppUser user;

  UserAuthenticatedState(this.user);

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        user,
        user.id.value,
      ];
}

final class UserAuthenticationErrorState extends UserState {
  final Object error;

  UserAuthenticationErrorState(this.error);

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        error,
      ];
}

final class UserAuthenticationPendingState extends UserState {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserLocalAuthRejectedState extends UserState {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserLocalAuthEmptyErrorState extends UserState {
  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
      ];
}

final class UserTenantSelectionState extends UserState {
  final List<Tenant> tenants;

  UserTenantSelectionState(this.tenants) : super();

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        ...tenants,
      ];
}
