import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  PersonSearchLoaded({required this.persons});
  final List<PersonEntity> persons;
  @override
  // TODO: implement props
  List<Object?> get props => [persons];
}

class PersonSearchError extends PersonSearchState {
  PersonSearchError({required this.message});
  final String message;
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
