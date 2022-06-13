import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_time/app/services/auth/auth_service_impl.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthServices _authService;

  // Estado inicial da aplicação
  LoginController({required AuthServices authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.signIn();
    } catch (e) {
      emit(state.copyWith(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }
}
