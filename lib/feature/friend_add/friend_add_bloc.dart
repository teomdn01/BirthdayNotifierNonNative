import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/model/friend_listing.dart';
import '../../domain/repository/friend_repository.dart';
import '../friend_update/friend_modify_bloc.dart';

class FriendAddBloc extends FriendModifyBloc {
  FriendAddBloc()
      : super(FriendListing.overloadedConstructor("", "", "", "", "", ""));
  @override
  Stream<FriendUpdateState> mapEventToState(FriendUpdateEvent event) async* {
    yield* super.mapEventToState(event);
    if (event is FriendAddSubmit) {
      yield const FriendUpdating();
      FriendListing newFriend =
          await super.friendRepository.addListing(listing);
      yield FriendUpdate(newFriend);
    }
  }
}
