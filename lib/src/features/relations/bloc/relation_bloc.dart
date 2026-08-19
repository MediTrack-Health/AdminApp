import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditrack_admin/src/core/utils/logger.dart';
import '../repo/relation_repo.dart';
import 'relation_event.dart';
import 'relation_state.dart';

class RelationBloc extends Bloc<RelationEvent, RelationState> {
  final RelationRepository relationRepository;

  RelationBloc(this.relationRepository) : super(RelationInitial()) {
    on<FetchRelationDetails>((event, emit) async {
      emit(RelationLoading());
      var data = {
        "mobileNumber": event.mobileNumber
      };
      try {
        final relations = await relationRepository.fetchRelationDetails(data);
        logger.d("Naresh relations $relations");
        emit(RelationLoaded(relations));
      } catch (e) {
        emit(RelationError(e.toString()));
      }
    });
  }
}