part of 'login_bloc.dart';

@immutable
sealed class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object> get props => [];
}

class InitLogin extends LoginEvents {
  const InitLogin();
  @override
  List<Object> get props => [];
}

class ProsesLogin extends LoginEvents {
  final String username;
  final String password;
  const ProsesLogin({this.username = "", this.password = ""});

  @override
  List<Object> get props => [username, password];
}

class ProsesLogout extends LoginEvents {
  const ProsesLogout();

  @override
  List<Object> get props => [];
}
