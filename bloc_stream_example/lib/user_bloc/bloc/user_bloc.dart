import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final users = List.generate(event.count,
        (index) => User(name: '$index User name', id: index.toString()));
    emit(state.copyWith(users: users));
  }

  _onGetUsersJob(UserGetUsersJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final job = List.generate(event.count,
        (index) => Job(name: '$index Job name', id: index.toString()));
    emit(state.copyWith(job: job));
  }

  UserBloc() : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUsersJob);
  }
}
