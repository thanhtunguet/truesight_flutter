part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserLoadingEvent extends UserEvent {}

final class UserOpenedAppEvent extends UserEvent {}

final class UserLoggedOutEvent extends UserEvent {}

/// Third Party Login
final class GoogleLoggedInEvent extends UserEvent {}

final class AppleLoggedInEvent extends UserEvent {}

///
final class UserSimpleLoginEvent extends UserEvent {
  final String username;

  final String password;

  UserSimpleLoginEvent({
    required this.username,
    required this.password,
  }) : super();
}

final class UserLoginErrorEvent extends UserEvent {
  final Object error;

  UserLoginErrorEvent(this.error) : super();
}

final class UserLoginSuccessEvent extends UserEvent {
  final TruesightAppUser user;

  UserLoginSuccessEvent(this.user);
}
