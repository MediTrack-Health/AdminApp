import 'package:equatable/equatable.dart';

import '../relation_details/relation_model.dart';

abstract class RelationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RelationInitial extends RelationState {}

class RelationLoading extends RelationState {}

class RelationLoaded extends RelationState {
  final List<RelationDetail> relations;

  RelationLoaded(this.relations);

  @override
  List<Object?> get props => [relations];
}

class RelationError extends RelationState {
  final String message;

  RelationError(this.message);

  @override
  List<Object?> get props => [message];
}