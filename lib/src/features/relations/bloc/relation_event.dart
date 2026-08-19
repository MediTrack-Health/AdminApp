import 'package:equatable/equatable.dart';

abstract class RelationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRelationDetails extends RelationEvent {
  final String mobileNumber;
  FetchRelationDetails(this.mobileNumber);
}
