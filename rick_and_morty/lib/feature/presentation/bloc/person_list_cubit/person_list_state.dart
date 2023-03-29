import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonState extends Equatable {
  const PersonState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
}
