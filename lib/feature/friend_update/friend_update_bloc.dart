import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moto_suchen/domain/exceptions/offline_exception.dart';

import '../../domain/model/friend_listing.dart';
import '../../domain/repository/friend_repository.dart';
import 'friend_modify_bloc.dart';

class FriendUpdateBloc extends FriendModifyBloc {
  FriendUpdateBloc(FriendListing listing) : super(listing);
  @override
  Stream<FriendUpdateState> mapEventToState(FriendUpdateEvent event) async* {
    yield* super.mapEventToState(event);
    if (event is FriendUpdateSubmit) {
      yield const FriendUpdating();
      try {
        FriendListing newFriend =
            await super.friendRepository.updateListing(listing);
        yield FriendUpdate(newFriend);
      } on OfflineException {
        yield const FriendOfflineUpdate();
      }
    }
  }
}
