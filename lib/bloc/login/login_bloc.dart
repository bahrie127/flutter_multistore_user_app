import 'package:bloc/bloc.dart';
import 'package:flutter_fic7_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_fic7_app/data/models/auth_response_model.dart';
import 'package:flutter_fic7_app/data/models/request/login_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final result = await AuthRemoteDatasource().login(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
