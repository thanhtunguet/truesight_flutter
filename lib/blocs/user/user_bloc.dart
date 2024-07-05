import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static const duration = Duration(seconds: 191);

  final authRepo = PortalAuthenticationRepository();

  final profileRepo = PortalProfileRepository();

  final notificationRepo = UtilsNotificationRepository();

  UserBloc() : super(UserInitial()) {
    on<UserSimpleLoginEvent>(_onSimpleLogin);
    on<UserLoadingEvent>(_onLoading);
    on<UserLoginSuccessEvent>(_onLoginSuccess);
    on<UserLoginErrorEvent>(_onLoginError);
    on<UserLoggedOutEvent>(_onUserLoggedOut);
    on<GoogleLoggedInEvent>(_onGoogleLoggedIn);
    on<AppleLoggedInEvent>(_onAppleLoggedIn);
    on<UserOpenedAppEvent>(_onUserOpenApp);
  }

  _onUserOpenApp(UserOpenedAppEvent event, Emitter<UserState> emit) {}

  _onGoogleLoggedIn(GoogleLoggedInEvent event, Emitter<UserState> emit) async {
    add(UserLoadingEvent());
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );
    try {
      final credentials = await googleSignIn.signIn();
      final googleKey = await credentials?.authentication;
      final tenants = await authRepo.googleLogin(googleKey!.idToken!);
      if (tenants.isNotEmpty) {
        await _handleLoginWithTenantId(tenants[0].id.value);
      }
    } catch (error) {
      errorHandlerService.captureException(error);
      add(UserLoginErrorEvent(error));
    }
  }

  _onAppleLoggedIn(AppleLoggedInEvent event, Emitter<UserState> emit) async {
    try {
      add(UserLoadingEvent());

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final tenants = await PortalAuthenticationRepository().appleLogin(credential.identityToken!);
      if (tenants.isNotEmpty) {
        await _handleLoginWithTenantId(tenants[0].id.value);
      }
    } catch (error) {
      errorHandlerService.captureException(error);
      add(UserLoginErrorEvent(error));
    }
  }

  Future<void> _handleLoginWithTenantId(int id) async {
    await authRepo.createToken(id);
    final user = await profileRepo.get();
    add(UserLoginSuccessEvent(user));
    try {
      await pushNotificationService.configureNotification(user.globalUserId.value);
    } catch (error) {
      errorHandlerService.captureException(error);
    }
  }

  Future<void> _onSimpleLogin(UserSimpleLoginEvent event, Emitter<UserState> emit) async {
    add(UserLoadingEvent());
    try {
      List<Tenant> tenants = await authRepo.login(event.username, event.password);
      await secureStorage.setSavedAccount(event.username, event.password);
      if (tenants.isNotEmpty) {
        final id = tenants[0].id.value;
        truesightService.tenantId = id;
        await _handleLoginWithTenantId(id);
      }
    } catch (error) {
      errorHandlerService.captureException(error);
      add(UserLoginErrorEvent(error));
    }
  }

  void _onUserLoggedOut(UserLoggedOutEvent event, Emitter<UserState> emit) async {
    await pushNotificationService.deleteToken();
    truesightService.removeTenantId();
    emit(UserInitial());
  }

  void _onLoading(UserLoadingEvent event, Emitter<UserState> emit) {
    emit(UserAuthenticationPendingState());
  }

  void _onLoginSuccess(UserLoginSuccessEvent event, Emitter<UserState> emit) {
    emit(UserAuthenticatedState(event.user));
  }

  _onLoginError(UserLoginErrorEvent event, Emitter<UserState> emit) {
    emit(UserAuthenticationErrorState(event.error));
  }
}
